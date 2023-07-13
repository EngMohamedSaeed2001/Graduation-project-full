// Import the functions you need from the SDKs you need
import {initializeApp} from "firebase/app";
import {getStorage} from "firebase/storage";
import {getDatabase} from "firebase/database";
import {getFirestore} from "firebase/firestore";

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyC0gzNoOwF8P5FxA65ufF9Zh57fsuDwYRU",
    authDomain: "semsark-529c0.firebaseapp.com",
    projectId: "semsark-529c0",
    storageBucket: "semsark-529c0.appspot.com",
    messagingSenderId: "788910457317",
    appId: "1:788910457317:web:8ca9cfd2e5e9ad9010af0c",
    measurementId: "G-L876XYDSSH"
};

const app = initializeApp(firebaseConfig);
let realtime = getDatabase(app);

let storage = getStorage(app);
let dataBase = getFirestore(app);

export {storage, dataBase,realtime};