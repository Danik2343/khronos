/*
* Copyright (c) 2020-2021 Lains
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/
public class Khronos.Application : Adw.Application {
    private const GLib.ActionEntry app_entries[] = {
        { "quit", quit },
    };

    public Application () {
        Object (application_id: Config.APP_ID);
    }
    public static int main (string[] args) {
        Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
        Intl.textdomain (Config.GETTEXT_PACKAGE);

        var app = new Khronos.Application ();
        return app.run (args);
    }
    protected override void startup () {
        resource_base_path = "/io/github/lainsce/Khronos";

        base.startup ();

        add_action_entries (app_entries, this);

        typeof (LogListView).ensure ();

        var repo = new LogRepository ();
        var view_model = new LogViewModel (repo);

        new MainWindow (this, view_model);
    }
    protected override void activate () {
        active_window?.present ();
    }
}
