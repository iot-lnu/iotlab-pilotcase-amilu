/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

/* eslint-disable no-unused-vars */

const {onRequest} = require("firebase-functions/v2/https");
const {getFirestore} = require("firebase-admin/firestore");
const {initializeApp} = require("firebase-admin/app");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

initializeApp();

exports.initGpsUnit = onRequest(async (request, response) => {
  const docRef = await getFirestore()
      .collection("users")
      .doc("5Feoqqb25FRU6j6onDSYhjSc4pW2")
      .collection("gpsUnits")
      .add({
        name: "",
      });
  response.status(200).send(docRef.id);
});

exports.postGpsData = onRequest(async (request, response) => {
  const {gpsUnitId, latitude, longitude} = request.body;
  const gpsUnitRef = getFirestore()
      .collection("users")
      .doc("5Feoqqb25FRU6j6onDSYhjSc4pW2")
      .collection("gpsUnits")
      .doc("VKY7QsPxpgyKpGJ0lM6T");

  const gpsDataRef = gpsUnitRef.collection("gpsData").doc();

  const batch = getFirestore().batch();

  batch.update(gpsUnitRef, {
    latitude,
    longitude,
    updatedAt: new Date(),
  });

  batch.set(gpsDataRef, {
    latitude,
    longitude,
    timestamp: new Date(),
  });

  await batch.commit();

  response.status(200).send("OK");
});
