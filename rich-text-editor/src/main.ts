import {Quill} from "quill";

type Callback = (s: string) => void;

type Options = {
  onSetContent: (callback: Callback) => void;
  onSave: Callback;
};

export function init(options: Options) {
  if (!(options.onSetContent instanceof Function)) {
    console.error("RichTextEditor.init: setContent is expected to be a function");
    return;
  }

  if (!(options.onSave instanceof Function)) {
    console.error("RichTextEditor.init: onSave is expected to be a function");
    return;
  }

  options.onSetContent((templateId: string) => {
    console.log("-- Quill received template ID", JSON.stringify(templateId));

    const editorContainer = document.createElement("div");
    const toolbar = document.createElement("div");
    const saveButton = document.createElement("button");
    saveButton.textContent = "Save";
    saveButton.addEventListener("click", () => {
      const editorContent = editorContainer.querySelector(".ql-editor");

      if (!editorContent) {
        console.error("Couldn’t find .ql-editor");
        return;
      }

      const html = editorContent.innerHTML;
      console.log("-- Quill is sending back html", JSON.stringify(html));
      options.onSave(html);

      document.body.removeChild(editorContainer);
      document.body.removeChild(toolbar);
    });

    toolbar.appendChild(saveButton);
    document.body.appendChild(toolbar);
    document.body.appendChild(editorContainer);

    const quill = new Quill(editorContainer, {
      modules: {
        toolbar: toolbar,
        history: {
          userOnly: true,
        },
      },
      theme: "snow",
    });

    const templateContainer = document.getElementById(templateId);
    const templateContent = templateContainer
      ? templateContainer.innerHTML
      : `(container not found: ${JSON.stringify(templateId)})`;

    quill.clipboard.dangerouslyPasteHTML(templateContent);
    quill.focus();
  });
}
