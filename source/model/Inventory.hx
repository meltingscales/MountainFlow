package model;

import entity.Item;
import entity.Items;
import util.Etc.*;

class Inventory
{
	private var data:Array<Item> = null;

	public function new(content = null)
	{
		if (content == null)
		{
			this.data = new Array<Item>();
		}
		else
		{
			this.data = content;
		}
	}

	public function num_items()
	{
		return this.data.length;
	}

	public function add(item:Item)
	{
		this.data.push(item);
	}

	public function pop()
	{
		return this.data.pop();
	}

	public function last_item()
	{
		return this.data[this.data.length - 1];
	}

	public function pretty_print():String
	{
		var id_counts = new Map();

		for (item in this.data)
		{
			if (!id_counts.exists(item.itemId))
			{
				id_counts[item.itemId] = 0;
			}

			id_counts[item.itemId] += 1;
		}

		var ret = "" + this.num_items() + " items in total\n";

		for (key in id_counts.keys())
		{
			var count = id_counts[key];
			var item = Items.by_id(key);

			ret += "" + count + " of " + item.name + "\n";
		}

		return ret;
	}
}
