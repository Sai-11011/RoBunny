// autocommit.js
import { GoogleGenerativeAI } from "@google/generative-ai";
import { execSync } from "child_process";
import dotenv from "dotenv";
import fs from "fs";

dotenv.config();

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

async function run() {
  try {
    // 1. Stage all changes
    console.log("➕ Staging all changes...");
    execSync("git add .");

    // 2. Check for staged changes
    const status = execSync("git diff --cached").toString();
    if (!status) {
      console.log("❌ No changes to commit!");
      return;
    }

    // 3. Ask Gemini to write the commit message
    console.log("🤖 Asking Gemini to write a commit message...");
    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
    const prompt = `You are a git expert. Write a concise commit message for these changes. 
    Follow the "Conventional Commits" format (e.g., feat:, fix:, docs:).
    Only output the message, nothing else.
    
    Changes:
    ${status.substring(0, 3000)}`; // Limit characters to avoid errors

    const result = await model.generateContent(prompt);
    const commitMessage = result.response.text().trim().replace(/"/g, '\\"');

    console.log(`\n📝 Generated Message: "${commitMessage}"`);

    // 4. Commit and Push
    console.log("🚀 Committing and Pushing...");
    execSync(`git commit -m "${commitMessage}"`);
    execSync("git push");
    console.log("✅ Done! Changes are on GitHub.");

  } catch (error) {
    console.error("Error:", error.message);
  }
}

run();