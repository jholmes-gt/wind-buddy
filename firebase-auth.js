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

import {
    resetClubs
} from "./WindBuddy.js";




// UI elements
const loginBtn = document.getElementById("loginBtn");
const menuSignOut = document.getElementById("menuSignOut");
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

if (loginBtn)
    console.log("loginBtn found");
else
    console.log("loginBtn NOT found");

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

menuSignOut.onclick = async () => {
    await signOut(auth);
    showToast("Sign out successful!<br>See you next time!", 3500);
    resetClubs();
};

// ----------------------------------------
// Auth State Listener
// ----------------------------------------

onAuthStateChanged(auth, (user) => {
    if (user) {
        loginBtn.classList.add("hidden");
        menuSignOut.classList.remove("hidden");
    } else {
        menuSignOut.classList.add("hidden");
        loginBtn.classList.remove("hidden");
    }
});


/* ----------------------------
   SHOW A TOAST MESSAGE
   ---------------------------- */
function showToast(message, duration = 3000) {
    const toastContainer = document.getElementById('toast-container');
    if (!toastContainer) {
        console.error("Toast container not found. Please add <div id='toast-container'></div> to your HTML.");
        return;
    }

    const toastElement = document.createElement('div');
    toastElement.classList.add('toast');

    // Allow HTML inside messages (for bold titles, <br>, etc.)
    toastElement.innerHTML = message;

    toastContainer.appendChild(toastElement);

    // Show the toast
    setTimeout(() => {
        toastElement.classList.add('show');
    }, 10);

    // Hide and remove the toast after the duration
    setTimeout(() => {
        toastElement.classList.remove('show');
        setTimeout(() => {
            toastContainer.removeChild(toastElement);
        }, 500);
    }, duration);
}


export {
  showToast
};

