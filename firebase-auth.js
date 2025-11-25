// firebase-auth.js
import { auth } from "./firebase-init.js";
import {
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  GoogleAuthProvider,
  signInWithPopup,
  signOut,
  onAuthStateChanged
} from "https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js";

/**
 * initAuth(onUserChange)
 * - wires UI buttons already present in your HTML (loginBtn, loginModal, etc)
 * - calls onUserChange(user) whenever auth state changes
 */
export function initAuth(onUserChange) {
  // elements (must exist in DOM)
  const loginBtn       = document.getElementById("loginBtn");
  const logoutBtn      = document.getElementById("logoutBtn");
  const loginModal     = document.getElementById("loginModal");
  const loginClose     = document.getElementById("loginClose");
  const emailLoginBtn  = document.getElementById("emailLoginBtn");
  const emailSignupBtn = document.getElementById("emailSignupBtn");
  const googleLoginBtn = document.getElementById("googleLoginBtn");
  const emailField     = document.getElementById("loginEmail");
  const passwordField  = document.getElementById("loginPassword");

  // defensive checks
  if (!loginBtn || !logoutBtn || !loginModal || !emailLoginBtn) {
    console.warn("Auth UI elements missing. Make sure your HTML includes the login modal and buttons.");
  }

  // show/hide modal
  loginBtn?.addEventListener("click", () => loginModal.classList.remove("hidden"));
  loginClose?.addEventListener("click", () => loginModal.classList.add("hidden"));

  // email sign-in
  emailLoginBtn?.addEventListener("click", async () => {
    try {
      await signInWithEmailAndPassword(auth, emailField.value, passwordField.value);
      loginModal.classList.add("hidden");
    } catch (err) {
      console.error("Email sign-in error:", err);
      alert(err.message || "Sign-in failed");
    }
  });

  // email signup
  emailSignupBtn?.addEventListener("click", async () => {
    try {
      await createUserWithEmailAndPassword(auth, emailField.value, passwordField.value);
      loginModal.classList.add("hidden");
    } catch (err) {
      console.error("Create account error:", err);
      alert(err.message || "Create account failed");
    }
  });

  // google signin
  googleLoginBtn?.addEventListener("click", async () => {
    try {
      const provider = new GoogleAuthProvider();
      provider.setCustomParameters({ prompt: "select_account" });
      await signInWithPopup(auth, provider);
      loginModal.classList.add("hidden");
    } catch (err) {
      console.error("Google sign-in error:", err);
      alert(err.message || "Google sign-in failed");
    }
  });

  // sign out
  logoutBtn?.addEventListener("click", async () => {
    try {
      await signOut(auth);
    } catch (err) {
      console.error("Sign out error:", err);
    }
  });

  // auth state changes
  onAuthStateChanged(auth, user => {
    if (user) {
      loginBtn?.classList?.add("hidden");
      logoutBtn?.classList?.remove("hidden");
    } else {
      logoutBtn?.classList?.add("hidden");
      loginBtn?.classList?.remove("hidden");
    }
    if (typeof onUserChange === "function") onUserChange(user || null);
  });
}
