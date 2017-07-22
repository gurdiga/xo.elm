import {Quill} from "quill";

const quill = new Quill("#rich-text-editor", {
  modules: {
    toolbar: [
      [{ header: [1, 2, false] }],
      ["bold", "italic", "underline"]
    ],
    history: {
      userOnly: true
    }
  },
  // scrollingContainer: "#scrolling-container", 
  placeholder: "Compose an epic...",
  theme: "snow",
});
