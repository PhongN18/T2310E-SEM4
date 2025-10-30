import 'dart:convert';
import 'dart:js_interop';

import 'package:orders_app/order.dart';
import 'package:web/web.dart' as web;

const String initialJson =
    '[{"Item": "A1000","ItemName": "Iphone 15","Price": 1200,"Currency":"USD","Quantity":1},'
    '{"Item": "A1001","ItemName": "Iphone 16","Price":1500,"Currency": "USD","Quantity":1}]';

final List<Order> _orders = <Order>[];

void main() {
  final decoded =
      (jsonDecode(initialJson) as List).cast<Map<String, dynamic>>();
  _orders
    ..clear()
    ..addAll(decoded.map((m) => Order.fromJson(_normalizeOrderMap(m))));

  _renderTable(_orders);

  final search = web.document.querySelector('#search') as web.HTMLInputElement?;
  search?.addEventListener(
      'input',
      ((web.Event _) {
        final q = (search.value ?? '').trim().toLowerCase();
        final filtered = q.isEmpty
            ? _orders
            : _orders
                .where((o) => o.itemName.toLowerCase().contains(q))
                .toList(growable: false);
        _renderTable(filtered);
      }).toJS);

  final form = web.document.querySelector('#orderForm') as web.HTMLFormElement?;
  final msg = web.document.querySelector('#formMsg') as web.HTMLElement?;
  form?.addEventListener(
      'submit',
      ((web.Event e) {
        e.preventDefault();

        final itemStr = _getValue(['#fItem']);
        final itemName = _getValue(['#fItemName', '#fName']);
        final priceStr = _getValue(['#fPrice']);
        final currency = _getValue(['#fCurrency']);
        final qtyStr = _getValue(['#fQuantity', '#fQty']);

        if (itemStr.isEmpty ||
            itemName.isEmpty ||
            priceStr.isEmpty ||
            currency.isEmpty ||
            qtyStr.isEmpty) {
          _setMsg(msg, 'Please fill all fields correctly.');
          return;
        }

        final price = num.tryParse(priceStr);
        final qty = int.tryParse(qtyStr);
        if (price == null || price < 0 || qty == null || qty <= 0) {
          _setMsg(msg, 'Invalid price/quantity.');
          return;
        }

        final exists = _orders.any(
            (o) => o.item.toString().toLowerCase() == itemStr.toLowerCase());
        if (exists) {
          _setMsg(msg, 'Item "$itemStr" already exists.');
          return;
        }

        final normalized = <String, dynamic>{
          'Item': itemStr,
          'ItemName': itemName.trim(),
          'Price': price,
          'Currency': currency.trim().toUpperCase(),
          'Quantity': qty,
        };
        final newOrder = Order.fromJson(_normalizeOrderMap(normalized));
        _orders.add(newOrder);

        final q = (search?.value ?? '').trim().toLowerCase();
        _renderTable(q.isEmpty
            ? _orders
            : _orders
                .where((o) => o.itemName.toLowerCase().contains(q))
                .toList());

        form.reset();
        _setMsg(msg, 'Inserted order ${newOrder.item}.', success: true);
      }).toJS);

  final downloadBtn =
      web.document.querySelector('#downloadBtn') as web.HTMLButtonElement?;
  downloadBtn?.addEventListener(
      'click',
      ((web.MouseEvent _) {
        final jsonList = _orders.map((o) => o.toJson()).toList();
        final pretty = const JsonEncoder.withIndent('  ').convert(jsonList);
        _downloadText(pretty, filename: 'order.json');
      }).toJS);
}

void _renderTable(List<Order> list) {
  final tbody =
      web.document.querySelector('#ordersBody') as web.HTMLTableSectionElement?;
  if (tbody == null) return;

  tbody.innerHTML = ''.toJS;

  if (list.isEmpty) {
    final tr = web.document.createElement('tr') as web.HTMLTableRowElement;
    final td = web.document.createElement('td') as web.HTMLTableCellElement;
    td.colSpan = 6;
    td.textContent = 'No orders match your search.';
    tr.append(td);
    tbody.append(tr);
    return;
  }

  for (final o in list) {
    final tr = web.document.createElement('tr') as web.HTMLTableRowElement;
    tr.append(_td(o.item.toString()));
    tr.append(_td(o.itemName));
    tr.append(_td(o.price.toString()));
    tr.append(_td(o.currency));
    tr.append(_td(o.quantity.toString()));
    tr.append(_actionCell(o));
    tbody.append(tr);
  }
}

web.HTMLTableCellElement _td(String text) {
  final td = web.document.createElement('td') as web.HTMLTableCellElement;
  td.textContent = text;
  return td;
}

web.HTMLTableCellElement _actionCell(Order order) {
  final td = web.document.createElement('td') as web.HTMLTableCellElement;
  final btn = web.document.createElement('button') as web.HTMLButtonElement;
  btn.textContent = 'Delete';
  btn.setAttribute('aria-label', 'Delete ${order.item}');
  // Optional styling hook; add CSS if you like:
  // btn.className = 'btn-danger'.toJS;
  btn.addEventListener(
      'click',
      ((web.MouseEvent _) {
        // Remove from the backing list
        _orders.removeWhere((o) =>
            o.item.toString().toLowerCase() ==
            order.item.toString().toLowerCase());
        // Respect current search filter when re-rendering
        final search =
            web.document.querySelector('#search') as web.HTMLInputElement?;
        final q = (search?.value ?? '').trim().toLowerCase();
        _renderTable(q.isEmpty
            ? _orders
            : _orders
                .where((o) => o.itemName.toLowerCase().contains(q))
                .toList());
      }).toJS);
  td.append(btn);
  return td;
}

void _downloadText(String content, {required String filename}) {
  final dataUrl =
      'data:application/json;charset=utf-8,' + Uri.encodeComponent(content);
  final a = web.document.createElement('a') as web.HTMLAnchorElement;
  a.setAttribute('href', dataUrl);
  a.setAttribute('download', filename);
  a.style.setProperty('display', 'none');
  web.document.body?.append(a);
  a.click();
  a.remove();
}

String _getValue(List<String> selectors) {
  for (final sel in selectors) {
    final el = web.document.querySelector(sel);
    if (el is web.HTMLInputElement) return el.value ?? '';
    if (el is web.HTMLSelectElement) return el.value ?? '';
    if (el != null) {
      try {
        final v = (el as dynamic).value as String?;
        if (v != null) return v;
      } catch (_) {}
    }
  }
  return '';
}

void _setMsg(web.HTMLElement? el, String text, {bool success = false}) {
  if (el == null) return;
  el.textContent = text;
  el.style.setProperty('color', success ? '#10b981' : '#eab308');
}

Map<String, dynamic> _normalizeOrderMap(Map<String, dynamic> m) {
  dynamic pick(List<String> keys) {
    for (final k in keys) {
      if (m.containsKey(k) && m[k] != null) return m[k];
    }
    return null;
  }

  final item = pick(['Item', 'item'])?.toString() ?? '';
  final itemName =
      pick(['ItemName', 'item_name', 'itemName'])?.toString() ?? '';
  final priceAny = pick(['Price', 'price']);
  final currency = pick(['Currency', 'currency'])?.toString() ?? '';
  final qtyAny = pick(['Quantity', 'quantity', 'qty']);

  final num price = priceAny is num
      ? priceAny
      : num.tryParse(priceAny?.toString() ?? '0') ?? 0;
  final int qty =
      qtyAny is int ? qtyAny : int.tryParse(qtyAny?.toString() ?? '0') ?? 0;

  return <String, dynamic>{
    'Item': item,
    'ItemName': itemName,
    'Price': price,
    'Currency': currency,
    'Quantity': qty,
  };
}
