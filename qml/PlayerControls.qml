/* This file is part of Music Shelf
 * Copyright (C) 2011 Martin Grimme  <martin.grimme _AT_ gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


import Qt 4.7

Rectangle {

    function formatTime(t) {
        t = t / 1000;
        var secs = Math.floor(t % 60);
        t = t / 60;
        var mins = Math.floor(t);
        if (secs < 10) secs = "0" + secs;
        return mins + ":" + secs;
    }

    signal settingsClicked()

    id: bar
    color: "black"

    BorderImage {
        anchors.fill: parent

        source: "panel.png"
        border.left: 4
        border.top: 4
        border.right: 4
        border.bottom: 4

        Row {
            id: leftButtons
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            ImageButton {
                source1: "previous_1.png"
                source2: "previous_2.png"
                onClicked: {
                    playQueue.previous();
                }
            }
            ImageButton {
                source1: player.isPlaying ? "pause_1.png" : "play_1.png"
                source2: player.isPlaying ? "pause_2.png" : "play_2.png"
                onClicked: {
                    player.pause();
                }
            }
            ImageButton {
                source1: "next_1.png"
                source2: "next_2.png"
                onClicked: {
                    playQueue.next();
                }
            }
        }

        Text {
            id: lblPosition
            anchors.left: leftButtons.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignRight
            width: 64
            color: "#a99d97"
            text: formatTime(player.position)
            font.pixelSize: 20

        }

        ProgressBar {
            id: progressBar
            anchors.left: lblPosition.right
            anchors.leftMargin: 12
            anchors.right: lblTotal.left
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height

            value: player.position / player.duration

            onClicked: {
                var millisecs = player.duration * value;
                player.position = millisecs;
            }
        }

        Text {
            id: lblTotal
            anchors.right: btnVolume.left
            anchors.rightMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignRight
            width: 64
            color: "#a99d97"
            text: formatTime(player.duration)
            font.pixelSize: 20
        }

        ImageButton {
            id: btnVolume
            anchors.right: volumeBar.left
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            source1: "volume.png"
            source2: "volume.png"
        }

        ProgressBar {
            id: volumeBar
            anchors.right: btnSettings.left
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: 128
            height: parent.height

            value: player.volume / 100.0

            onClicked: {
                player.volume = value * 100.0;
            }
        }

        ImageButton {
            id: btnSettings
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            source1: "settings_1.png"
            source2: "settings_2.png"

            onClicked: {
                bar.settingsClicked();
            }
        }
    }
}