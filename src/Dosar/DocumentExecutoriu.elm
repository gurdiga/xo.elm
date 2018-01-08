module Dosar.DocumentExecutoriu exposing (Model, empty, view, Msg, update)

import Html
import Html.Styled exposing (fromUnstyled, Html, fieldset, legend, div, button, br, text)
import Widgets.Select3 as Select3


-- import Utils.MyHtmlEvents exposing (onClick)

import Utils.MyDate as MyDate


-- import Utils.MyList as MyList
-- import Widgets.Fields exposing (largeTextField)

import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
import Dosar.Persoana as Persoana
import Dosar.DocumentExecutoriu.Pricina as Pricina
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata
import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare as DocumenteAplicareMasuriAsigurare exposing (DocumenteAplicareMasuriAsigurare)


type Msg
    = SetInstantaEmitatoare (Select3.Msg InstantaDeJudecata.Model)
    | SetPricina (Select3.Msg Pricina.Model)
    | SetDataPronuntareHotarire DateField.Msg
    | SetDispozitivul LargeTextField.Msg
    | SetDataRamineriiDefinitive DateField.Msg
    | SetDataEliberarii DateField.Msg
      -- | SetDebitor Int Persoana.Msg
    | SetMentiuniPrivindPatrundereaFortata LargeTextField.Msg
    | SetLocPastrareBunuriSechestrate LargeTextField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetInstantaEmitatoare select3Msg ->
            receiveInstantaEmitatoare (Model model) (Select3.update select3Msg model.ui.instantaEmitatoare)

        SetPricina select3Msg ->
            receivePricina (Model model) (Select3.update select3Msg model.ui.pricina)

        SetDataPronuntareHotarire dateFieldMsg ->
            Model { model | dataPronuntareHotarire = DateField.update dateFieldMsg model.dataPronuntareHotarire }

        SetDispozitivul largeTextFieldMsg ->
            Model { model | dispozitivul = LargeTextField.update largeTextFieldMsg model.dispozitivul }

        SetDataRamineriiDefinitive dateFieldMsg ->
            Model { model | dataRamineriiDefinitive = DateField.update dateFieldMsg model.dataRamineriiDefinitive }

        SetDataEliberarii dateFieldMsg ->
            Model { model | dataEliberarii = DateField.update dateFieldMsg model.dataEliberarii }

        SetMentiuniPrivindPatrundereaFortata largeTextFieldMsg ->
            Model { model | mentiuniPrivindPatrundereaFortata = LargeTextField.update largeTextFieldMsg model.mentiuniPrivindPatrundereaFortata }

        SetLocPastrareBunuriSechestrate largeTextFieldMsg ->
            Model { model | locPastrareBunuriSechestrate = LargeTextField.update largeTextFieldMsg model.locPastrareBunuriSechestrate }

        SetNote largeTextFieldMsg ->
            Model { model | note = LargeTextField.update largeTextFieldMsg model.note }


receiveInstantaEmitatoare : Model -> Select3.Model InstantaDeJudecata.Model -> Model
receiveInstantaEmitatoare (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | instantaEmitatoare = newSelect }
            , instantaEmitatoare = Select3.selectedValue newSelect
        }


receivePricina : Model -> Select3.Model Pricina.Model -> Model
receivePricina (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | pricina = newSelect }
            , pricina = Select3.selectedValue newSelect
        }


type Model
    = Model
        { instantaEmitatoare : InstantaDeJudecata.Model
        , pricina : Pricina.Model
        , dataPronuntareHotarire : MyDate.Model
        , dispozitivul : String
        , dataRamineriiDefinitive : MyDate.Model
        , debitori : List Persoana.Model
        , dataEliberarii : MyDate.Model
        , documenteAplicareMasuriAsigurare : DocumenteAplicareMasuriAsigurare
        , mentiuniPrivindPatrundereaFortata : String
        , locPastrareBunuriSechestrate : String
        , note : String
        , ui : Ui
        }


type alias Ui =
    { instantaEmitatoare : Select3.Model InstantaDeJudecata.Model
    , pricina : Select3.Model Pricina.Model
    }


empty : Model
empty =
    Model
        { instantaEmitatoare = InstantaDeJudecata.initialModel
        , pricina = Pricina.initialModel
        , dataPronuntareHotarire = MyDate.empty
        , dispozitivul = ""
        , dataRamineriiDefinitive = MyDate.empty
        , debitori = [ Persoana.initialModel ]
        , dataEliberarii = MyDate.empty
        , documenteAplicareMasuriAsigurare = DocumenteAplicareMasuriAsigurare.empty
        , mentiuniPrivindPatrundereaFortata = ""
        , locPastrareBunuriSechestrate = ""
        , note = ""
        , ui =
            { instantaEmitatoare = Select3.initialModel InstantaDeJudecata.initialModel InstantaDeJudecata.valuesWithLabels
            , pricina = Select3.initialModel Pricina.initialModel Pricina.valuesWithLabels
            }
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "DocumentExecutoriu" ]
        , Select3.view "Instanța de judecată:" model.ui.instantaEmitatoare |> Html.map SetInstantaEmitatoare |> fromUnstyled
        , Select3.view "Pricina:" model.ui.pricina |> Html.map SetPricina |> fromUnstyled
        , DateField.view "Data pronunțării hotărîrii:" model.dataPronuntareHotarire |> Html.map SetDataPronuntareHotarire |> fromUnstyled
        , LargeTextField.view "Dispozitivul:" model.dispozitivul |> Html.map SetDispozitivul |> fromUnstyled
        , DateField.view "Data rămînerii definitive:" model.dataRamineriiDefinitive |> Html.map SetDataRamineriiDefinitive |> fromUnstyled

        -- , debitoriView model.debitori (\v -> c { model | debitori = v })
        , DateField.view "Data eliberării:" model.dataEliberarii |> Html.map SetDataEliberarii |> fromUnstyled

        -- , DocumenteAplicareMasuriAsigurare.view
        --     model.documenteAplicareMasuriAsigurare
        --     (\v -> c { model | documenteAplicareMasuriAsigurare = v })
        , LargeTextField.view "Mențiuni privind autorizarea pătrunderii forțate:" model.mentiuniPrivindPatrundereaFortata
            |> Html.map SetMentiuniPrivindPatrundereaFortata
            |> fromUnstyled
        , LargeTextField.view "Locul de păstrare a bunurilor sechestrate:" model.locPastrareBunuriSechestrate
            |> Html.map SetLocPastrareBunuriSechestrate
            |> fromUnstyled
        , LargeTextField.view "Note:" model.note |> Html.map SetNote |> fromUnstyled
        ]



-- debitoriView : List Persoana.Model -> (List Persoana.Model -> msg) -> Html msg
-- debitoriView debitori callback =
--     fieldset []
--         ([ legend [] [ text "Debitori" ] ]
--             ++ List.indexedMap
--                 (\i debitor ->
--                     Persoana.view debitor |> Html.map (SetDebitor i)
--                  -- (\v -> callback (MyList.replace debitori i v))
--                 )
--                 debitori
--             ++ [ button [ onClick (\_ -> callback (debitori ++ [ Persoana.initialModel ])) ] [ text "+" ] ]
--         )
