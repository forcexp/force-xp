/** Class desgined to be used as base class for classes that implement the command pattern.
 * Commands should be designed to be executed only once.
 * Commands should be designed to be executed again only if undo() has been called and successfully executed.
 * More about the command pattern at: https://refactoring.guru/design-patterns/command
 */
public abstract class Command {
	// #region Public members
	public void execute() {
		throwExceptionIfItHasBeenExecutedBefore();

		executeAccordingToTheSharingModifier();
		markAsExecuted();
	}

	public void undo() {
		throwExceptionIfItHasNotBeenExecutedBefore();

		onUndo();
		markAsNotExecuted();
	}

	public void setToExecuteWithSharing() {
		sharingModifier = SharingModifiers.WITH_SHARING;
	}

	public void setToExecuteWithoutSharing() {
		sharingModifier = SharingModifiers.WITHOUT_SHARING;
	}

	public abstract class CommandException extends CustomException {
	}

	public interface CanExecute {
		void execute();
	}

	public interface CanUndo {
		void undo();
	}

	public interface CanExecuteInFuture {
		void executeInFuture();
	}

	public interface UseRecord {
		Boolean hasRecord();
		void setRecord(SObject record);
	}

	public interface UseRecords {
		Boolean hasRecords();
		void setRecords(List<SObject> records);
	}

	/**
	 * CommandAlreadyExecutedException should never be created outside FxpCommand class.
	 */
	public class CommandAlreadyExecutedException extends CommandException {
	}

	/**
	 * CommandNeverExecutedException should never be created outside FxpCommand class.
	 */
	public class CommandNeverExecutedException extends CommandException {
	}

	public enum SharingModifiers {
		INHERITED_SHARING,
		WITH_SHARING,
		WITHOUT_SHARING
	}
	// #endregion

	// #region Private members
	@TestVisible
	protected virtual void onExecute() {
		throw NotImplementedException.newInstance();
	}

	@TestVisible
	protected virtual void onUndo() {
		throw NotImplementedException.newInstance();
	}
	// #endregion

	// #region Private members
	static final CommandExecutor WITH_SHARING_EXECUTOR = new WithSharingExecutor();
	static final CommandExecutor WITHOUT_SHARING_EXECUTOR = new WithoutSharingExecutor();
	static final CommandExecutor INHERITED_SHARING_EXECUTOR = new InheritedSharingExecutor();

	Boolean executed = false;
	SharingModifiers sharingModifier = SharingModifiers.INHERITED_SHARING;

	void throwExceptionIfItHasBeenExecutedBefore() {
		if (executed) {
			throw new CommandAlreadyExecutedException(
				'Command cannot be executed because it has already been executed.'
			);
		}
	}

	void throwExceptionIfItHasNotBeenExecutedBefore() {
		if (!executed) {
			throw new CommandNeverExecutedException(
				'Command cannot be undone because it has not been executed.'
			);
		}
	}

	void executeAccordingToTheSharingModifier() {
		if (sharingModifier == SharingModifiers.WITH_SHARING) {
			WITH_SHARING_EXECUTOR.execute(this);
			return;
		}

		if (sharingModifier == SharingModifiers.WITHOUT_SHARING) {
			WITHOUT_SHARING_EXECUTOR.execute(this);
			return;
		}

		INHERITED_SHARING_EXECUTOR.execute(this);
	}

	void markAsExecuted() {
		executed = true;
	}

	void markAsNotExecuted() {
		executed = true;
	}

	interface CommandExecutor {
		void execute(Command command);
	}

	with sharing class WithSharingExecutor
			implements CommandExecutor {
		public void execute(Command command) {
			command.onExecute();
		}
	}

	without sharing class WithoutSharingExecutor
			implements CommandExecutor {
		public void execute(Command command) {
			command.onExecute();
		}
	}

	inherited sharing class InheritedSharingExecutor
			implements CommandExecutor {
		public void execute(Command command) {
			command.onExecute();
		}
	}
	// #endregion
}
