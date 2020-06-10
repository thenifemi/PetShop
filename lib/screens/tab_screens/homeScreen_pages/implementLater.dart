// stream: Firestore.instance
//                       .collection('food')
//                       .document(prodDetails.productID)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     var quantity = snapshot.data['quantity'];

//                     void addQty() {
//                       setState(() {
//                         if (quantity > 9) {
//                           Firestore.instance
//                               .runTransaction((transaction) async {
//                             DocumentSnapshot freshSnap =
//                                 await transaction.get(snapshot.data.reference);
//                             await transaction.update(freshSnap.reference, {
//                               'quantity': freshSnap['quantity'] - 1,
//                             });
//                           });
//                         } else if (quantity < 9) {
//                           setState(() {
//                             Firestore.instance
//                                 .runTransaction((transaction) async {
//                               DocumentSnapshot freshSnap = await transaction
//                                   .get(snapshot.data.reference);
//                               await transaction.update(freshSnap.reference, {
//                                 'quantity': freshSnap['quantity'] + 1,
//                               });
//                             });
//                           });
//                         }
//                       });
//                     }

//                     void subQty() {
//                       setState(() {
//                         if (quantity != 1) {
//                           Firestore.instance
//                               .runTransaction((transaction) async {
//                             DocumentSnapshot freshSnap =
//                                 await transaction.get(snapshot.data.reference);
//                             await transaction.update(freshSnap.reference, {
//                               'quantity': freshSnap['quantity'] - 1,
//                             });
//                           });
//                         } else if (quantity < 1) {
//                           setState(() {
//                             Firestore.instance
//                                 .runTransaction((transaction) async {
//                               DocumentSnapshot freshSnap = await transaction
//                                   .get(snapshot.data.reference);
//                               await transaction.update(freshSnap.reference, {
//                                 'quantity': freshSnap['quantity'] + 1,
//                               });
//                             });
//                           });
//                         }
//                       });
//                     }
//                   }