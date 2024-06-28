// const functions = require("firebase-functions");
// const admin = require("firebase-admin");
// admin.initializeApp();

// exports.notifyOnUserChange = functions.firestore
//     .document("users/{userId}")
//     .onWrite(async (change, context) => {
//       const userId = context.params.userId;
//       const userRef = admin.firestore().collection("users").doc(userId);

//       // Fetch the updated user data
//       const userSnapshot = await userRef.get();
//       const userData = userSnapshot.data();

//       if (!userData.tokens || userData.tokens.length === 0) {
//         console.log("No tokens found for user:", userId);
//         return;
//       }

//       const payload = {
//         notification: {
//           title: "User Update",
//           body: `Changes have been made to your profile.`,
//         },
//       };

//       // Send notifications to all tokens
//       const tokens = userData.tokens;
//       const response = await admin.messaging().sendToDevice(tokens, payload);

//       // Remove invalid tokens
//       const invalidTokens = [];
//       response.results.forEach((result, index) => {
//         const error = result.error;
//         if (error) {
//           console.error(
//               "Failure sending notification to",
//               tokens[index],
//               error,
//           );
//           if (
//             error.code === "messaging/invalid-registration-token" ||
//           error.code === "messaging/registration-token-not-registered"
//           ) {
//             invalidTokens.push(tokens[index]);
//           }
//         }
//       });

//       await userRef.update({
//         tokens: admin.firestore.FieldValue.arrayRemove(...invalidTokens),
//       });
//     });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.myFunction = functions.https.onCall((data, context) => {
  const message = data.message;
  return {response: `Received message: ${message}`};
});


exports.createUserDocument = functions.https.onCall(async (data, context) => {
  const newUser = {
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    // Add any other fields you want to include in the document
    name: data.name || "Anonymous",
    email: data.email || "no-email@example.com",
  };

  try {
    const docRef = await db.collection("users").add(newUser);
    return {success: true, id: docRef.id};
  } catch (error) {
    console.error("Error creating document: ", error);
    return {success: false, error: error.message};
  }
});


exports.sendNotification = functions.https.onRequest(async (req, res) => {
  // Validate the input data
  const {name, tokens, message} = req.body;

  if (!name || !tokens || !message) {
    // eslint-disable-next-line max-len
    return res.status(400).json({success: false, error: "Name, tokens, and message are required fields."});
  }

  // Prepare the notification message
  const notification = {
    notification: {
      title: `Hello, ${name}!`,
      body: message,
    },
    tokens: tokens, // Array of device tokens
  };

  try {
    // Send the notification
    const response = await admin.messaging().sendMulticast(notification);
    console.log("Successfully sent message:", response);

    return res.status(200).json({success: true, response: response});
  } catch (error) {
    console.error("Error sending notification: ", error);
    return res.status(500).json({success: false, error: error.message});
  }
});
