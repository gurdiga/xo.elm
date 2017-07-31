import {Quill} from "quill";

// This widget assumes that there will be at most one instance of RTE open at
// any given time, and it will be closed before openeing another one.

type Callback = (s: string) => void;

type Options = {
  onSetContent: (callback: Callback) => void;
  onSave: Callback;
};

export function init(options: Options) {
  assertFunction(options, "onSetContent");
  assertFunction(options, "onSave");

  options.onSetContent((templateId: string) => {
    console.log("-- RichTextEditor received template ID", JSON.stringify(templateId));

    withEditorMarkup((editorToolbar, editorContainer) => {
      const quill = new Quill(editorContainer, {
        modules: {
          toolbar: editorToolbar,
          history: {
            userOnly: true,
          },
        },
        theme: "snow",
      });

      const content = querySelector("#" + templateId).innerHTML;
      quill.clipboard.dangerouslyPasteHTML(content);
      quill.focus();
    }, options.onSave);
  });
}

function assertFunction(object: any, propertyName: string): void {
  if (!(object[propertyName] instanceof Function)) {
    throw new Error(`RichTextEditor.init: ${propertyName} option is expected to be a function`);
  }
}

function withEditorMarkup(
  initQuill: (editorToolbar: HTMLElement, editorContainer: HTMLElement) => void,
  onSave: Options["onSave"],
): void {
  const editorContainer = document.createElement("div");
  const editorToolbar = document.createElement("div");
  editorToolbar.innerHTML = `
        <button class="rte-save">Save</button>
        <button class="rte-close">Close</button>
      `;

  querySelector("button.rte-save", editorToolbar).addEventListener("click", () => {
    const editorContent = querySelector(".ql-editor", editorContainer);
    const html = editorContent.innerHTML;

    console.log("-- RichTextEditor is sending back html", JSON.stringify(html));
    onSave(html);
    destroy();
  });

  querySelector("button.rte-close", editorToolbar).addEventListener("click", destroy);

  document.body.appendChild(editorToolbar);
  document.body.appendChild(editorContainer);

  function destroy() {
    document.body.removeChild(editorContainer);
    document.body.removeChild(editorToolbar);
  }

  initQuill(editorToolbar, editorContainer);
}

function querySelector(selector: string, containerElement: Element = document.documentElement): Element {
  const element = containerElement.querySelector(selector);

  if (!element) {
    throw new Error(`Could not find element by selector: ${JSON.stringify(selector)} in ${containerElement}.`);
  }

  return element;
}
