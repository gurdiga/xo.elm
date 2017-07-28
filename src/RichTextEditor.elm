port module RichTextEditor exposing (send, onResponse, DocumentTemplate(TemplateActPreluare, TemplateIncheiereIntentare))


type DocumentTemplate
    = TemplateActPreluare
    | TemplateIncheiereIntentare


send : String -> Cmd msg
send =
    sendToEditor


onResponse : (String -> msg) -> Sub msg
onResponse =
    onResponseFromEditor


port sendToEditor : String -> Cmd msg


port onResponseFromEditor : (String -> msg) -> Sub msg
