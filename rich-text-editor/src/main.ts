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
    toolbar.innerHTML = `
      <button class="rte-save">Save</button>
      <button class="rte-close">Close</button>
    `;

    querySelector("button.rte-save", toolbar).addEventListener("click", () => {
      const editorContent = querySelector(".ql-editor", editorContainer);
      const html = editorContent.innerHTML;

      console.log("-- Quill is sending back html", JSON.stringify(html));
      options.onSave(html);
      destroyEditor();
    });
    querySelector("button.rte-close", toolbar).addEventListener("click", destroyEditor);

    document.body.appendChild(toolbar);
    document.body.appendChild(editorContainer);

    function destroyEditor() {
      document.body.removeChild(editorContainer);
      document.body.removeChild(toolbar);
    }

    const quill = new Quill(editorContainer, {
      modules: {
        toolbar: toolbar,
        history: {
          userOnly: true,
        },
      },
      theme: "snow",
    });

    const templateContainer = querySelector("#" + templateId);
    const templateContent = templateContainer.innerHTML;
    quill.clipboard.dangerouslyPasteHTML(templateContent);
    quill.focus();
  });
}

function querySelector(selector: string, containerElement: Element = document.documentElement): Element {
  const element = containerElement.querySelector(selector);

  if (!element) {
    throw new Error(`Could not find element by selector: ${JSON.stringify(selector)} in ${containerElement}.`);
  }

  return element;
}
