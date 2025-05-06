import { error } from "console";
import fs from "fs";

const filepath = "./hello.txt";

// Write to a file (Asynchronously)
fs.writeFile(filepath, "Hello, Node.js beginner!", (writeError) => {
  console.log("Write Error: ", writeError);
  return;
});

// Read the file (Asynchronously)
fs.readFile(filepath, "utf8", (readErr, content) => {
  if (readErr) {
    console.log("Read Error : ", readErr);
    return;
  }
  console.log("File content:", content);
});
