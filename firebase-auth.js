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
    onAuthStateChanged,
    sendEmailVerification
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


loginBtn.onclick = () => loginModal.classList.remove("hidden");
loginClose.onclick = () => loginModal.classList.add("hidden");


// ------------------------------
// FIREBASE EMAIL/PASSWORD SIGNUP
// ------------------------------

emailSignupBtn.onclick = async () => {
  try {
    const userCred = await createUserWithEmailAndPassword(
      auth,
      emailField.value,
      passwordField.value
    );

    // Send verification email
    await sendEmailVerification(userCred.user);
    loginModal.classList.add("hidden");
    alert("Account created! Please check your email and verify your account before signing in.");
    await auth.signOut();
  } catch (error) {
    console.error("Create account with user/password error:", error);
    alert("There was an error creating your account. Please try again.");
  };
};

// ------------------------------
// EMAIL LOGIN (BLOCK IF UNVERIFIED)
// ------------------------------

emailLoginBtn.onclick = async () => {
  try {
    const userCred = await signInWithEmailAndPassword(
      auth,
      emailField.value,
      passwordField.value
    );
    
    loginModal.classList.add("hidden");
    // REFRESH user data to check verification state
    await userCred.user.reload();

    if (!userCred.user.emailVerified) {
      resendVerificationEmail();
      await auth.signOut();
      showVerifyModal();
      return;
    }
    window.scroll(0,0)
    showToast("Signed in!", 5000);

  } catch (err) {
    window.scroll(0,0)
    showToast(err.message, 5000);
  }
};

// ------------------------------
// RESEND VERIFICATION EMAIL
// (called by account menu)
// ------------------------------

async function resendVerificationEmail() {
  const user = auth.currentUser;
  if (!user) return;

  await sendEmailVerification(user);
  window.scroll(0,0)
  showToast("Verification email resent!", 5000);
}

// ------------------------------
// VERIFICATION MODAL
// ------------------------------

function showVerifyModal() {
  const verifyBox = document.getElementById("verifyModal");
  verifyBox.classList.remove("hidden");
}

document.getElementById("verifyModalClose").onclick = () => {
  document.getElementById("verifyModal").classList.add("hidden");
};




// ------------------------------
// AUTH STATE LISTENER
// ------------------------------

onAuthStateChanged(auth, async () => {
  const user = auth.currentUser
  if (!user) {
    loginBtn.classList.remove("hidden");
    menuSignOut.classList.add("hidden");
    return;
  }

  // Google users are always verified
//   const provider = user.providerData[0]?.providerId;
//   if (provider === "password") {
//     await user.reload();
//     if (!user.emailVerified) {
//       await auth.signOut();
//       showVerifyModal();
//       return;
//     }
//   }

  loginBtn.classList.add("hidden");
  menuSignOut.classList.remove("hidden");
});


// ----------------------------------------
// Google Login
// ----------------------------------------

googleLoginBtn.onclick = async () => {
    try {
        await signInWithPopup(auth, googleProvider);
        loginModal.classList.add("hidden");
        window.scroll(0,0)
        showToast("Signed in with Google!", 5000);
    } catch (err) {
        window.scroll(0,0)
        showToast(err.message, 5000);
    }
};

// ----------------------------------------
// Logout
// ----------------------------------------

menuSignOut.onclick = async () => {
    await signOut(auth);
    window.scroll(0,0)
    showToast("Sign out successful!<br>See you next time!", 5000);
    resetClubs();
};


/* ----------------------------
   SHOW A TOAST MESSAGE
   ---------------------------- */
function showToast(message, duration = 3000) {
    const toastContainer = document.getElementById('toastContainer');
    if (!toastContainer) {
        console.error("Toast container not found. Please add <div id='toastContainer'></div> to your HTML.");
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
  showToast,
  resendVerificationEmail
};

