import Web3 from "web3";
import { useState } from "react";
import { initializeApp } from "firebase/app";
import { getAuth, signInWithCustomToken, signOut } from "firebase/auth";

import "./App.css";
import ConnectWalletButton from "./components/ConnectWalletButton";
import mobileCheck from "./helpers/mobileCheck";
import getLinker from "./helpers/deepLink";

const firebaseConfig = {
  apiKey: "EDIT_THIS",
  authDomain: "EDIT_THIS",
  projectId: "EDIT_THIS",
  storageBucket: "EDIT_THIS",
  messagingSenderId: "EDIT_THIS",
  appId: "EDIT_THIS"
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
