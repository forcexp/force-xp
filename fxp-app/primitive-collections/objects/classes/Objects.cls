/**
 * @description: Objects is a collection of objects. In other words, Objects is used to
 * manipulate collections of different data types.
 */
public class Objects extends Collection {
	public Objects(Object value) {
		super(new List<Object>{value});
	}

	public Objects(Object value1,Object value2) {
		super(new List<Object>{value1, value2});
	}

	public Objects(Object value1,Object value2, Object value3) {
		super(new List<Object>{value1, value2, value3});
	}

	public Objects(List<Object> values) {
		super(values);
	}

	public Objects(Set<Object> values) {
		super(new List<Object>(values));
	}

	public List<Object> asList() {
		return items;
	}

	public Set<Object> asSet() {
		return itemsAsSet;
	}

	public Object item() {
		return item;
	}
}
