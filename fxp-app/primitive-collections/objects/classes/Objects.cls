/**
 * @description: Objects is a collection of objects. In other words, Objects is used to
 * manipulate collections of different data types.
 */
public class Objects extends Collection {
	public Objects(Object value) {
		this(new List<Object>{value});
	}

	public Objects(Object value1,Object value2) {
		this(new List<Object>{value1, value2});
	}

	public Objects(Object value1,Object value2, Object value3) {
		this(new List<Object>{value1, value2, value3});
	}

	public Objects(List<Object> values) {
		super(values, new MetaOperations());
	}

	public Objects(Set<Object> values) {
		this(new List<Object>(values));
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

	class MetaOperations extends Collection.MetaOperations {

		public override Type listType() {
			return List<Object>.class;
		}

		public override Object newCollection(List<Object> items) {
			return new Objects(items);
		}
	}
}
