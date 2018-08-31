module Dosar.DocumentExecutoriu exposing (Model, Msg, empty, update, view)

-- import Utils.MyHtmlEvents exposing (onClick)
-- import Utils.MyList as MyList
-- import Widgets.Fields exposing (largeTextField)

import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare as DocumenteAplicareMasuriAsigurare exposing (DocumenteAplicareMasuriAsigurare)
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata
import Dosar.DocumentExecutoriu.Pricina as Pricina
import Dosar.Persoana as Persoana
import Html exposing (Html, br, button, div, fieldset, legend, map, text)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
import Widgets.Select4 as Select4


type Msg
    = SetInstantaEmitatoare InstantaDeJudecata.Model
    | SetPricina Pricina.Model
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
        SetInstantaEmitatoare v ->
            Model { model | instantaEmitatoare = v }

        SetPricina v ->
            Model { model | pricina = v }

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
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "DocumentExecutoriu" ]
        , Select4.view <|
            Select4.config
                { label = "Instanța de judecată:"
                , valuesWithLabels = InstantaDeJudecata.valuesWithLabels
                , defaultValue = model.instantaEmitatoare
                , onInput = SetInstantaEmitatoare
                }
        , Select4.view <|
            Select4.config
                { label = "Pricina:"
                , valuesWithLabels = Pricina.valuesWithLabels
                , defaultValue = model.pricina
                , onInput = SetPricina
                }
        , DateField.view "Data pronunțării hotărîrii:" model.dataPronuntareHotarire |> map SetDataPronuntareHotarire
        , LargeTextField.view "Dispozitivul:" model.dispozitivul |> map SetDispozitivul
        , DateField.view "Data rămînerii definitive:" model.dataRamineriiDefinitive |> map SetDataRamineriiDefinitive

        -- , debitoriView model.debitori (\v -> c { model | debitori = v })
        , DateField.view "Data eliberării:" model.dataEliberarii |> map SetDataEliberarii

        -- , DocumenteAplicareMasuriAsigurare.view
        --     model.documenteAplicareMasuriAsigurare
        --     (\v -> c { model | documenteAplicareMasuriAsigurare = v })
        , LargeTextField.view "Mențiuni privind autorizarea pătrunderii forțate:" model.mentiuniPrivindPatrundereaFortata
            |> map SetMentiuniPrivindPatrundereaFortata
        , LargeTextField.view "Locul de păstrare a bunurilor sechestrate:" model.locPastrareBunuriSechestrate
            |> map SetLocPastrareBunuriSechestrate
        , LargeTextField.view "Note:" model.note |> map SetNote
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
