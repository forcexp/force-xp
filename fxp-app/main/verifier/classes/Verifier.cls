public class Verifier {
	public Verifier() {

	}

	public Verifier forValue(Object value) {
		return this;
	}

	public Verifier require(Situation situation) {
		return this;
	}

	public Verifier prevent(Situation situation) {
		return this;
	}

	public void verify() {

	}

	public abstract class Situation {
		public abstract Boolean evaluate(Object value);
	}

	List<Situation> situationsToPrevent = new List<Situation> {
		new ValueIsNull()
	};

	List<Situation> situationsToRequire = new List<Situation> {
	};

	class ValueIsNull extends Situation {
		public override Boolean evaluate(Object value) {
			return value == null;
		}
	}

	class VerificationQueue {
		void addValue()
	}
}
