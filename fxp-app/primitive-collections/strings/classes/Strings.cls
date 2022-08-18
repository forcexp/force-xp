public class Strings extends Collection {
	public Strings(String value) {
		this(new List<String>{value});
	}

	public Strings(String value1,String value2) {
		this(new List<String>{value1, value2});
	}

	public Strings(String value1, String value2, String value3) {
		this(new List<String>{value1, value2, value3});
	}

	public Strings(List<String> values) {
		super(values, new MetaOperations());
	}

	public Strings(Set<String> values) {
		this(new List<String>(values));
	}

	public List<String> asList() {
		return (List<String>)operations.itemsAsNewTypedList();
	}

	public Set<String> asSet() {
		Set<String> result = new Set<String>();
		for(Object item: items) {
			result.add(String.valueOf(item));
		}
		return result;
	}

	public String item() {
		return (String)item;
	}

	/**
	 * @description Returns a new String Collection where the items are abbreviated. Ellipses are
	 * appended to those items where the length is greater than the maxLength; otherwise the item
	 * is preserverd as it is.
	 * @argument maxWith has to be equal or greater than 4.
	 */
	public Strings abbreviate(Integer maxWidth) {
		// FIXME throw exception if maxWidth is null or less than 4
		return (Strings)operations.mapCollection(new AbbreviateItemsMapper(maxWidth));
	}

	// public String abbreviate(Integer maxWidth, Integer offset)

	// FIXME write documentation
	public Strings capitalize() {
		return (Strings)operations.mapCollection(new CapitalizeItemsMapper());
	}

	class AbbreviateItemsMapper extends ItemMapper {
		Integer maxWidth;

		public AbbreviateItemsMapper(Integer maxWidth) {
			this.maxWidth = maxWidth;
		}

		public override Object mapItem(Object item) {
			return ((String)item).abbreviate(maxWidth);
		}
	}

	class CapitalizeItemsMapper extends ItemMapper {
		public override Object mapItem(Object item) {
			return ((String)item).capitalize();
		}
	}

	class MetaOperations extends Collection.MetaOperations {

		public override Type listType() {
			return List<String>.class;
		}

		public override Object newCollection(List<Object> items) {
			return new Strings((List<String>)items);
		}
	}
}
