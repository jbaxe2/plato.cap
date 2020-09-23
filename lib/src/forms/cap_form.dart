library plato.cap.form;

/// The [CapForm] abstract class...
abstract class CapForm {
  final String name;

  final DateTime date;

  /// The [CapForm] constructor...
  CapForm (this.name, this.date);
}

/// A [List] of the summary of ratings criteria.
const RatingsCriteria = {
  'Element', 'Quality', 'Scope', 'Consistency', 'Readiness Thresholds Met? (Y/N)'
};

/// A [Map] of the summary of ratings elements.
const FormElements = {
  '1.A.1': 'Subject Matter Knowledge',
  '1.A.3': 'Well-Structured Units and Lessons',
  '1.B.2': 'Adjustments to Practice',
  '2.A.3': 'Meeting Diverse Needs',
  '2.B.1': 'Safe Learning Environment',
  '2.E.1': 'High Expectations',
  '4.A.1': 'Reflective Practice'
};

/// The [List] of the summary of ratings scores.
const RatingScores = {
  'P', 'NI', 'Y', 'N'
};
