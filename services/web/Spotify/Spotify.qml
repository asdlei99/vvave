import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../../view_models"
import "../../../view_models/BabeTable"
import org.kde.kirigami 2.2 as Kirigami


Page
{

    Loader
    {
        id: loginLoader
    }

    ColumnLayout
    {
        anchors.fill: parent

        spacing: 0

        BabeTable
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            headerBarExit: false
            headerBarLeft: BabeButton
            {
                iconName: "internet-services"
                onClicked:if(!isAndroid)
                {

                    loginLoader.source = "LoginForm.qml"

                    loginLoader.item.open()

                }
            }
        }

        ToolBar
        {
            id: searchBox
            Layout.fillWidth: true
            position: ToolBar.Footer

            RowLayout
            {
                anchors.fill: parent

                TextInput
                {
                    id: searchInput
                    color: textColor
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment:  Text.AlignVCenter
                    selectByMouse: !isMobile
                    selectionColor: highlightColor
                    selectedTextColor: highlightedTextColor
                    focus: true
                    text: ""
                    wrapMode: TextEdit.Wrap
                    onAccepted: runSearch(searchInput.text)

                }

                BabeButton
                {
                    Layout.rightMargin: contentMargins
                    iconName: "edit-clear"
                    onClicked: searchInput.clear()
                }

            }
        }
    }
}
