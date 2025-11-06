import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// Configuration du projet Vite
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: "dist",
  },
});
