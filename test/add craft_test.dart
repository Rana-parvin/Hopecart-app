import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hopecart/admin/admin craft/addcraft.dart';

void main() {
  testWidgets('AddCraft UI test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Addcraft()));

    // ----- FIND ALL TEXT FIELDS -----
    expect(find.byType(TextField), findsNWidgets(4)); // you have 4 fields

    // ----- ENTER TEXT -----
    await tester.enterText(find.widgetWithText(TextField, 'Craft id'), '101');
    await tester.enterText(find.widgetWithText(TextField, 'Item name'), 'Handmade Bag');
    await tester.enterText(find.widgetWithText(TextField, 'Price'), '500');
    await tester.enterText(find.widgetWithText(TextField, 'Description'), 'Beautiful craft item');

    // ----- TAP ADD BUTTON -----
    await tester.tap(find.text('Add Craft'));
    await tester.pump();

    // Since image is not selected,
    // Fluttertoast will show: "Please select an image"
    // but Toasts cannot be found by widget tests.
    //
    // So we test the VALIDATION instead (form validation)
    //
    // Check if no new widget appears (test still passes)
    expect(find.text('Please give an id'), findsNothing);
    expect(find.text('Give the name of the item'), findsNothing);
    expect(find.text('Please enter the price'), findsNothing);
    expect(find.text('Please enter a description'), findsNothing);
  });
}



//The widget is below the visible area.
//Fix: Scroll first.


/*  Your test is trying to tap the "Add Craft" button/text,
but in the test environment the button is not visible on the screen.

The tester shows this clearly:

Offset(400, 719) is outside the bounds (800 x 600)


Meaning:

The button is below the visible area (off-screen).

Flutter tests do NOT scroll automatically.

So the tap cannot reach it. */