import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopecart/user/user craft/view cart.dart';
import 'package:hopecart/user/user%20craft/cart%20removal.dart';


class Cartitemdetails extends StatefulWidget {
  final Cartitems item;

  const Cartitemdetails({super.key, required this.item});

  @override
  State<Cartitemdetails> createState() => _CartitemdetailsState();
}

class _CartitemdetailsState extends State<Cartitemdetails> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = int.tryParse(widget.item.qnty) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
    //  backgroundColor: const Color(0xFFF6F5FF),
      appBar: AppBar(centerTitle: true,
     //   backgroundColor: const Color(0xFFF6F5FF),
        elevation: 0,
        title: Text(
          "Item Details",
          style: GoogleFonts.petrona(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: const Color(0xFF76421E),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),

            // ---- IMAGE CARD ----
            Center(
              child: Container(
                height: 220,
                width: w * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 5),
                        color: Colors.black12)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: widget.item.image.isEmpty
                      ? Image.asset("assets/images/meal.jpeg", fit: BoxFit.cover)
                      : Image.network(widget.item.image, fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---- PRODUCT NAME ----
            Text(
              widget.item.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            // ---- PRICE ----
            Text(
              "₹${widget.item.price}",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 20),

            // ---- DESCRIPTION CARD ----
            Container(
              width: w * 0.85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 8,
                      offset: Offset(0, 3),
                      color: Colors.black12)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.des,
                    style: GoogleFonts.nunito(fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---- QUANTITY SELECTOR ----
            Text("Quantity",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 18)),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                quantityButton(Icons.remove, () {
                  if (quantity > 1) {
                    setState(() => quantity--);
                  }
                }),
                const SizedBox(width: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange.withOpacity(0.1),
                  ),
                  child: Text(
                    quantity.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
               const SizedBox(width: 20),
                quantityButton(Icons.add, () {
                  setState(() => quantity++);
                }),
              ],
            ),

            const SizedBox(height: 30),

            // ---- BOTTOM BUTTONS ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               bottomButton(
  icon: Icons.delete_outline,
  text: "Remove",
  color: Colors.red,
  onTap: () async {
    // Show a confirmation dialog before deleting
    bool? confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm"),
        content: const Text("Do you want to remove this item from cart?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel",style: TextStyle(color:Colors.red ),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Yes",  style: TextStyle(color:Colors.red )),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Call the delete function
    bool success = await CartRemoval.delrecord(widget.item.id);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item removed from cart")),
      );
      Navigator.pop(context); // Go back after deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to remove item")),
      );
    }
  },
),

                bottomButton(
                  icon: Icons.shopping_bag,
                  text: "Buy Now",
                  color: Colors.deepOrange,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ------------ WIDGETS -----------------

  Widget quantityButton(IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.deepOrange.withOpacity(0.2)),
        child: Icon(icon, color: Colors.deepOrange, size: 22),
      ),
    );
  }

  Widget bottomButton(
      {required IconData icon,
      required String text,
      required Color color,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 140,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
