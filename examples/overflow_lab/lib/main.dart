import 'package:flutter/material.dart';

const broken = bool.fromEnvironment('BROKEN_LAYOUTS');
const productName = 'Waterproof hiking boots';
const shippingDetails =
    'Delivery requires a signature from an adult at the shipping address.';
const addButton = Key('add-to-cart');
const shippingText = Key('shipping-details');
const addressField = Key('address');
const submitButton = Key('submit');
const confirmButton = Key('confirm');
const checkoutScroll = Key('checkout-scroll');
const sheetScroll = Key('sheet-scroll');

void main() => runApp(const OverflowLab());

class OverflowLab extends StatelessWidget {
  const OverflowLab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overflow Lab',
      home: Scaffold(
        appBar: AppBar(title: const Text('Overflow Lab')),
        body: Builder(
          builder: (context) => ListView(
            children: [
              for (final (name, demo) in <(String, Widget)>[
                ('Product card', const ProductDemo()),
                ('Shipping details', const ShippingDemo()),
                ('Checkout form', const CheckoutDemo()),
                ('Confirmation sheet', const SheetDemo()),
                ('Carousel', const CarouselDemo()),
              ])
                ListTile(
                  title: Text(name),
                  onTap: () => Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(builder: (context) => demo),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDemo extends StatefulWidget {
  const ProductDemo({super.key});

  @override
  State<ProductDemo> createState() => _ProductDemoState();
}

class _ProductDemoState extends State<ProductDemo> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    const name = Text(productName);
    const price = Text('\$129');
    final action = FilledButton(
      key: addButton,
      onPressed: () => setState(() => added = true),
      child: const Text('Add to cart'),
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (broken) return Row(children: [name, price, action]);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (constraints.maxWidth < 480)
                      name
                    else
                      const Row(
                        children: [
                          Expanded(child: name),
                          price,
                        ],
                      ),
                    Wrap(
                      spacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [if (constraints.maxWidth < 480) price, action],
                    ),
                  ],
                );
              },
            ),
            if (added) const Text('Added to cart'),
          ],
        ),
      ),
    );
  }
}

class ShippingDemo extends StatelessWidget {
  const ShippingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Text(
              shippingDetails,
              key: shippingText,
              maxLines: broken ? 1 : null,
              overflow: broken ? TextOverflow.ellipsis : TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutDemo extends StatelessWidget {
  const CheckoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = <Widget>[
      const TextField(
        key: addressField,
        decoration: InputDecoration(labelText: 'Address'),
      ),
      const TextField(decoration: InputDecoration(labelText: 'Postal code')),
      const TextField(decoration: InputDecoration(labelText: 'City')),
      const TextField(decoration: InputDecoration(labelText: 'Delivery notes')),
      const SizedBox(height: 16),
      FilledButton(
        key: submitButton,
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Order sent'))),
        child: const Text('Send order'),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: !broken,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: broken
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: fields,
                )
              : ListView(key: checkoutScroll, children: fields),
        ),
      ),
    );
  }
}

class SheetDemo extends StatefulWidget {
  const SheetDemo({super.key});

  @override
  State<SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<SheetDemo> {
  bool confirmed = false;

  Future<void> openSheet() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        const details = Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Confirm the shipping address and delivery instructions.',
          ),
        );
        final action = FilledButton(
          key: confirmButton,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Confirm order'),
        );
        return SizedBox(
          height: 160,
          child: broken
              ? Stack(
                  children: [
                    details,
                    Positioned(top: 168, left: 16, child: action),
                  ],
                )
              : ListView(
                  key: sheetScroll,
                  padding: const EdgeInsets.all(8),
                  children: [details, action],
                ),
        );
      },
    );
    if (mounted && result == true) setState(() => confirmed = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(onPressed: openSheet, child: const Text('Open sheet')),
            if (confirmed) const Text('Order confirmed'),
          ],
        ),
      ),
    );
  }
}

class CarouselDemo extends StatelessWidget {
  const CarouselDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var index = 1; index <= 5; index++)
                  SizedBox(
                    width: 160,
                    child: Center(child: Text('Photo $index')),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
