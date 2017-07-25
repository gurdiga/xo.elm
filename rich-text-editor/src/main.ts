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

  options.onSetContent((s: string) => {
    const editorContainer = createEditorContainer();
    const toolbarContainer = createTollbarContainer();

    document.body.appendChild(toolbarContainer);
    document.body.appendChild(editorContainer);

    const quill = new Quill(editorContainer, {
      modules: {
        toolbar: toolbarContainer,
        history: {
          userOnly: true,
        },
      },
      theme: "snow",
    });

    console.log("-- Quill received text", JSON.stringify(s));
    quill.setText(s);
    quill.focus();

    const saveButton = toolbarContainer.querySelector("button")!;
    saveButton.addEventListener("click", () => {
      const text = quill.getText().trim();
      console.log("-- Quill is sending back text", JSON.stringify(text));
      options.onSave(text);

      document.body.removeChild(editorContainer);
      document.body.removeChild(toolbarContainer);
    });
  });
}

function createEditorContainer(): HTMLElement {
  return document.createElement("div");
}

function createTollbarContainer(): HTMLElement {
  const toolbar = document.createElement("div");

  const saveButton = document.createElement("button");
  saveButton.textContent = "Save";

  toolbar.appendChild(saveButton);
  return toolbar;
}
