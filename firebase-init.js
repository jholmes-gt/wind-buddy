// ----------------------------------------
// firebase-init.js
// Initializes Firebase using modular v10 SDK
// ----------------------------------------

import { initializeApp } from "https://www.gstatic.com/firebasejs/10.11.0/firebase-app.js";
import { 
    getAuth, 
    GoogleAuthProvider, 
    signInWithEmailAndPassword,
    createUserWithEmailAndPassword,
    signInWithPopup,
    signOut,
    onAuthStateChanged
} from "https://www.gstatic.com/firebasejs/10.11.0/firebase-auth.js";

import { 
    getFirestore, 
    doc, 
    getDoc, 
    setDoc,
    collection
} from "https://www.gstatic.com/firebasejs/10.11.0/firebase-firestore.js";

// ----------------------------------------
// Your Firebase config
// ----------------------------------------

const firebaseConfig = {
    apiKey: "AIzaSyABJDtHSjWRkxQYbBkyrPfbMcMqbq0whaw",
    authDomain: "windbuddy-7560a.firebaseapp.com",
    projectId: "windbuddy-7560a",
    storageBucket: "windbuddy-7560a.firebasestorage.app",
    messagingSenderId: "685091043542",
    appId: "1:685091043542:web:d710463180ed82fb0b7177"
};

// ----------------------------------------
// Initialize Firebase Services
// ----------------------------------------

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);
const googleProvider = new GoogleAuthProvider();

// ----------------------------------------
// Export everything for import use
// ----------------------------------------

export {
    auth,
    db,
    googleProvider,
    signInWithEmailAndPassword,
    createUserWithEmailAndPassword,
    signInWithPopup,
    signOut,
    onAuthStateChanged,
    doc,
    getDoc,
    setDoc,
    collection
};
