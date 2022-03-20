package model;

import entity.Item;

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
		return "lol todo.. but we do have " + this.data.length + " items, and we most recently picked up " + this.last_item().name;
	}
}
