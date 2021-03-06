import QtQuick 2.0
import QtQuick.Controls 2.10
import org.kde.mauikit 1.0 as Maui
import "../view_models/BabeTable"
import "../db/Queries.js" as Q
import org.maui.vvave 1.0 as Vvave

Maui.Page
{
    id: control
    property alias list : _filterList
    property alias listModel : _filterList.model
    property var tracks : []
    property string currentFolder : ""

    flickable: browser.flickable

    Maui.GridBrowser
    {
        id: browser
        anchors.fill: parent
        showEmblem: false
        model: ListModel {}
        cellHeight: itemSize * 1.2
        onItemClicked:
        {
            var item = browser.model.get(index)
            _filterList.listModel.filter = ""
            currentFolder = item.path
            filter()
            _listDialog.open()
        }
    }

    Maui.Holder
    {
        anchors.fill: parent
        visible: !browser.count
        emoji: "qrc:/assets/dialog-information.svg"
        isMask: true
        title : qsTr("No Folders!")
        body: qsTr("Add new music to your sources to browse by folders")
        emojiSize: Maui.Style.iconSizes.huge
    }

    Maui.Dialog
    {
        id: _listDialog
        parent: parent
        maxHeight: maxWidth
        maxWidth: Maui.Style.unit * 600
        defaultButtons: false
        page.padding: 0

        BabeTable
        {
            id: _filterList
            anchors.fill: parent
            coverArtVisible: true
            holder.emoji: "qrc:/assets/MusicCloud.png"
            holder.isMask: true
            holder.title : qsTr("No Tracks!")
            holder.body: qsTr("This source folder seems to be empty!")
            holder.emojiSize: Maui.Style.iconSizes.huge
        }
    }

    Component.onCompleted: populate()

    function populate()
    {
        browser.model.clear()
        var folders = Vvave.Vvave.sourceFolders();
        if(folders.length > 0)
            for(var i in folders)
                browser.model.append(folders[i])
    }

    function filter()
    {
        var where = "source = \""+currentFolder+"\""
        _filterList.list.query = (Q.GET.tracksWhere_.arg(where))

    }
}
