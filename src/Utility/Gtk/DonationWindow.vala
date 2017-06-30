/*
 * DonationWindow.vala
 *
 * Copyright 2012-2017 Tony George <teejeetech@gmail.com>
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
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 *
 */

using Gtk;

using TeeJee.Logging;
using TeeJee.FileSystem;
using TeeJee.JsonHelper;
using TeeJee.ProcessHelper;
using TeeJee.System;
using TeeJee.Misc;
using TeeJee.GtkHelper;

public class DonationWindow : Dialog {

	private string username = "";
	
	public DonationWindow() {
		
		set_title(_("Author's Note"));
		window_position = WindowPosition.CENTER_ON_PARENT;
		set_destroy_with_parent (true);
		set_modal (true);
		set_deletable(true);
		set_skip_taskbar_hint(false);
		set_default_size (500, 20);
		icon = get_app_icon(16);

		//vbox_main
		Box vbox_main = get_content_area();
		vbox_main.margin = 6;
		vbox_main.spacing = 6;
		vbox_main.homogeneous = false;

		get_action_area().visible = false;

		var label = new Gtk.Label("");

		string msg = _("This application was created for my own use. I work on it during my free time based on my requirements and interest. I'm distributing it in the hope that it will be useful to someone.\n\n▰ You can leave a donation via PayPal if you wish to say thanks\n\n▰ Use the issue tracker to report issues, ask questions and request features\n\n▰ This application comes with absolutely no warranty. See the terms of the GNU General Public License v2 for more details.\n\nThanks,\nTony George");
		
		label.label = msg;
		label.wrap = true;
		label.xalign = 0.0f;
		label.yalign = 0.0f;
		label.margin_bottom = 6;
		vbox_main.pack_start(label, true, true, 0);

		var hbox = new Gtk.Box(Orientation.HORIZONTAL, 6);
		hbox.margin_top = 24;
		vbox_main.pack_start(hbox, false, false, 0);
		
		var bbox = new Gtk.ButtonBox(Orientation.HORIZONTAL);
		//bbox.set_layout(Gtk.ButtonBoxStyle.EXPAND);
		bbox.set_spacing(6);
		bbox.set_homogeneous(false);
		hbox.add(bbox);

		if (get_user_id_effective() == 0){
			username = get_username();
		}
		
		//btn_donate_paypal
		var button = new Gtk.Button.with_label(_("Donate with PayPal"));
		button.set_tooltip_text("Donate to: teejeetech@gmail.com");
		bbox.add(button);
		button.clicked.connect(() => {
			xdg_open("https://www.paypal.com/cgi-bin/webscr?business=teejeetech@gmail.com&cmd=_xclick&currency_code=USD&amount=10&item_name=Polo%20Donation", username);
		});

		//btn_donate_wallet
		button = new Gtk.Button.with_label(_("Become a Patron"));
		button.set_tooltip_text("https://www.patreon.com/bePatron?u=3059450");
		bbox.add(button);
		button.clicked.connect(() => {
			xdg_open("https://www.patreon.com/bePatron?u=3059450", username);
		});

		bbox = new Gtk.ButtonBox(Orientation.HORIZONTAL);
		//bbox.set_layout(Gtk.ButtonBoxStyle.EXPAND);
		bbox.set_spacing(6);
		bbox.set_homogeneous(false);
		hbox.add(bbox);
		
		//tracker
		button = new Gtk.Button.with_label(_("Tracker"));
		button.set_tooltip_text("https://github.com/teejee2008/polo/issues");
		bbox.add(button);
		button.clicked.connect(() => {
			xdg_open("https://github.com/teejee2008/polo/issues", username);
		});

		//btn_visit
		button = new Gtk.Button.with_label(_("Website"));
		button.set_tooltip_text("http://www.teejeetech.in");
		bbox.add(button);
		button.clicked.connect(() => {
			xdg_open("http://www.teejeetech.in", username);
		});

		//btn_visit
		button = new Gtk.Button.with_label(_("Close"));
		hbox.add(button);
		button.clicked.connect(() => {
			this.destroy();
		});
	}
}

