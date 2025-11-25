// firebase-init.js
// Initialize Firebase (modular SDK) and export auth + db

import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-firestore.js";

const firebaseConfig = {
  apiKey: "AIzaSyABJDtHSjWRkxQYbBkyrPfbMcMqbq0whaw",
  authDomain: "windbuddy-7560a.firebaseapp.com",
  projectId: "windbuddy-7560a",
  storageBucket: "windbuddy-7560a.firebasestorage.app",
  messagingSenderId: "685091043542",
  appId: "1:685091043542:web:d710463180ed82fb0b7177"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);
