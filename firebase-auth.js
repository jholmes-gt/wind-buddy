// ----------------------------------------
// firebase-auth.js
// Handles all login UI + authentication events
// ----------------------------------------

import {
    auth,
    googleProvider,
    signInWithEmailAndPassword,
    createUserWithEmailAndPassword,
    signInWithPopup,
    signOut,
    onAuthStateChanged
} from "./firebase-init.js";

// UI elements
const loginBtn = document.getElementById("loginBtn");
const logoutBtn = document.getElementById("logoutBtn");
const loginModal = document.getElementById("loginModal");
const loginClose = document.getElementById("loginClose");

const emailLoginBtn = document.getElementById("emailLoginBtn");
const emailSignupBtn = document.getElementById("emailSignupBtn");
const googleLoginBtn = document.getElementById("googleLoginBtn");

const emailField = document.getElementById("loginEmail");
const passwordField = document.getElementById("loginPassword");

// ----------------------------------------
// Modal show/hide
// ----------------------------------------

loginBtn.onclick = () => loginModal.classList.remove("hidden");
loginClose.onclick = () => loginModal.classList.add("hidden");

// ----------------------------------------
// Email Login
// ----------------------------------------

emailLoginBtn.onclick = async () => {
    try {
        await signInWithEmailAndPassword(auth, emailField.value, passwordField.value);
        loginModal.classList.add("hidden");
        showToast("Signed in!", 2500);
    } catch (err) {
        showToast(err.message, 4000);
    }
};

// ----------------------------------------
// Email Signup
// ----------------------------------------

emailSignupBtn.onclick = async () => {
    try {
        await createUserWithEmailAndPassword(auth, emailField.value, passwordField.value);
        loginModal.classList.add("hidden");
        showToast("Account created!", 2500);
    } catch (err) {
        showToast(err.message, 4000);
    }
};

// ----------------------------------------
// Google Login
// ----------------------------------------

googleLoginBtn.onclick = async () => {
    try {
        await signInWithPopup(auth, googleProvider);
        loginModal.classList.add("hidden");
        showToast("Signed in with Google!", 2500);
    } catch (err) {
        showToast(err.message, 4000);
    }
};

// ----------------------------------------
// Logout
// ----------------------------------------

logoutBtn.onclick = async () => {
    await signOut(auth);
    showToast("Signed out", 2000);
};

// ----------------------------------------
// Auth State Listener
// ----------------------------------------

onAuthStateChanged(auth, (user) => {
    if (user) {
        loginBtn.classList.add("hidden");
        logoutBtn.classList.remove("hidden");
    } else {
        logoutBtn.classList.add("hidden");
        loginBtn.classList.remove("hidden");
    }
});
