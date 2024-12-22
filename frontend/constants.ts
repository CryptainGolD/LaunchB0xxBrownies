export const NETWORK = import.meta.env.VITE_APP_NETWORK ?? "testnet";
export const MODULE_ADDRESS = import.meta.env.VITE_MODULE_ADDRESS ?? "0xcfddca9f69cb06c797c91e21ce510a8a252dacd88e3e1777164b9453aa460298";
export const CREATOR_ADDRESS = import.meta.env.VITE_FA_CREATOR_ADDRESS;
export const FA_ADDRESS = import.meta.env.VITE_FA_ADDRESS;
export const IS_DEV = Boolean(import.meta.env.DEV);
export const IS_PROD = Boolean(import.meta.env.PROD);
export const APTOS_API_KEY = import.meta.env.VITE_APTOS_API_KEY;
