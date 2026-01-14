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
    onAuthStateChanged,
    sendPasswordResetEmail,
    deleteUser,
    reauthenticateWithCredential,
    reauthenticateWithPopup,
    EmailAuthProvider,
    sendEmailVerification
} from "https://www.gstatic.com/firebasejs/10.11.0/firebase-auth.js";

import { 
    getFirestore, 
    doc, 
    getDoc, 
    getDocs,
    setDoc,
    collection,
    deleteDoc,
    updateDoc,
    deleteField
} from "https://www.gstatic.com/firebasejs/10.11.0/firebase-firestore.js";


import { getAnalytics, logEvent } from "https://www.gstatic.com/firebasejs/10.11.0/firebase-analytics.js";

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
const analytics = getAnalytics(app);


// ----------------------------------------
// Analytics Event Logging
// ----------------------------------------
function trackPageView(path = window.location.pathname) {
  logEvent(analytics, 'page_view', {
    page_path: path,
    page_title: document.title
  });
}

// Initial load
trackPageView();

// Patch pushState to catch SPA navigation
const originalPushState = history.pushState;
history.pushState = function () {
  originalPushState.apply(this, arguments);
  trackPageView();
};

// Catch back/forward
window.addEventListener('popstate', () => {
  trackPageView();
});


logEvent(analytics, 'signup_started');

logEvent(analytics, 'signup_completed');

logEvent(analytics, 'tool_used');

logEvent(analytics, 'club_changed', {
  club_type: 'driver'
});


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
    getDocs,
    setDoc,
    collection,
    sendPasswordResetEmail,
    deleteDoc,
    updateDoc,
    deleteField,
    deleteUser,
    reauthenticateWithCredential,
    reauthenticateWithPopup,
    EmailAuthProvider,
    sendEmailVerification
};
