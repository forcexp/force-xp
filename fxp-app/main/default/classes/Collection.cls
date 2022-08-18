/**
 * @description Collection is an abstract class to be used as base to all classes
 * aiming to manipulate groups of objects of the same type.
 * Collections cannot be created with empty lists. By definition, Collections must contains at least one object.
 */
public abstract class Collection {

	protected Collection(List<Object> objects, MetaOperations metaOperations) {
		new NullArgumentBlocker()
				.forArgument(objects)
				.forArgument(metaOperations)
				.throwExceptionIfAnyHasIssues();
		privateItems = new List<Object>(objects);
		privateMetaOperations = metaOperations;
		privateMetaOperations.collection = this;
	}

	public Boolean areMany {
		get {
			return areManyGetterResult();
		}
	}

	public Boolean areNotMany {
		get {
			return areNotManyGetterResult();
		}
	}

	public Boolean isJustOne {
		get {
			return isJustOneGetterResult();
		}
	}

	public Boolean isNotJustOne {
		get {
			return isNotJustOneGetterResult();
		}
	}

	public Integer size {
		get {
			return sizeGetterResult();
		}
	}

	public virtual Objects asObjects() {
		return new Objects(items);
	}

	public abstract class MetaOperations {
		Collection collection;

		public abstract Type listType();

		public abstract Object newCollection(List<Object> items);

		public List<Object> newEmptyTypedList() {
			return (List<Object>)listType().newInstance();
		}

		public List<Object> itemsAsNewTypedList() {
			List<Object> items = newEmptyTypedList();

			for(Object item: collection.privateItems) {
				items.add(item);
			}

			return items;
		}

		public Object mapCollection(ItemMapper mapper) {
			List<Object> mappedItems = newEmptyTypedList();

			for(Object item: collection.privateItems) {
				mappedItems.add(mapper.mapItem(item));
			}

			return newCollection(mappedItems);
		}
	}

	public abstract class ItemMapper {
		public abstract Object mapItem(Object item);
	}

	protected List<Object> items {
		get {
			return itemsGetterResult();
		}
	}

	protected Set<Object> itemsAsSet {
		get {
			return itemsAsSetGetterResult();
		}
	}

	protected Object item {
		get {
			return itemGetterResult();
		}
	}

	protected MetaOperations operations {
		get {
			return privateMetaOperations;
		}
	}

	protected virtual Boolean areManyGetterResult() {
		return privateItems.size() > 1;
	}

	protected virtual Boolean areNotManyGetterResult() {
		return !areMany;
	}

	protected virtual Boolean isJustOneGetterResult() {
		return privateItems.size() == 1;
	}

	protected virtual Boolean isNotJustOneGetterResult() {
		return !isJustOne;
	}

	protected virtual Integer sizeGetterResult() {
		return privateItems.size();
	}

	protected virtual List<Object> itemsGetterResult() {
		return operations.itemsAsNewTypedList();
	}

	protected virtual Set<Object> itemsAsSetGetterResult() {
		return new Set<Object>(privateItems);
	}

	protected virtual Object itemGetterResult() {
		abortGetItemWhenCollectionHasManyItems();
		return privateItems[0];
	}

	//protected abstract Object mapCollection(ItemMapper mapper);

	List<Object> privateItems;
	MetaOperations privateMetaOperations;

	void abortGetItemWhenCollectionHasManyItems() {
		if (areMany) {
			throw new InvalidOperationOnCollectionWithManyItemsException(
				'Can use <this>.item on a Collection with many items.'
			);
		}
	}

	class InvalidOperationOnCollectionWithManyItemsException extends InvalidOperationException { }

}
