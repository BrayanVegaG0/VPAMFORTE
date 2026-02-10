import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/survey_submission_model.dart';
import '../../models/survey_history_model.dart';

abstract class SurveyLocalDataSource {
  Future<void> saveDraft(SurveySubmissionModel draft);
  Future<SurveySubmissionModel?> loadDraft(String surveyId);
  Future<void> clearDraft(String surveyId);

  Future<void> enqueuePending(SurveySubmissionModel pending);
  Future<List<SurveySubmissionModel>> loadPending(String surveyId);
  Future<void> updatePending(SurveySubmissionModel updated);

  Future<void> removePending(SurveySubmissionModel item);

  Future<void> addToSentHistory(
    SurveySubmissionModel sent, {
    required String remoteCode,
    required String remoteMessage,
  });
  Future<List<Map<String, dynamic>>> loadSentHistory(String surveyId);

  Future<void> clearPendingAll(String surveyId);
  Future<void> removePendingById(String surveyId, String createdAtIso);

  Future<void> saveHistoryItem(SurveyHistoryModel item);
  Future<List<SurveyHistoryModel>> getHistory();
}

class SurveyLocalDataSourcePrefs implements SurveyLocalDataSource {
  final SharedPreferences prefs;
  SurveyLocalDataSourcePrefs({required this.prefs});

  String _draftKey(String surveyId) => 'survey_draft_$surveyId';
  String _pendingKey(String surveyId) => 'survey_pending_$surveyId';

  String _historyKey(String surveyId) => 'survey_sent_history_$surveyId';
  String get _surveySentHistoryKey =>
      'survey_history_items_v1'; // Historial resumido

  @override
  Future<void> saveDraft(SurveySubmissionModel draft) async {
    await prefs.setString(
      _draftKey(draft.surveyId),
      jsonEncode(draft.toJson()),
    );
  }

  @override
  Future<SurveySubmissionModel?> loadDraft(String surveyId) async {
    final raw = prefs.getString(_draftKey(surveyId));
    if (raw == null || raw.isEmpty) return null;
    return SurveySubmissionModel.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> clearDraft(String surveyId) async {
    await prefs.remove(_draftKey(surveyId));
  }

  @override
  Future<void> enqueuePending(SurveySubmissionModel pending) async {
    final key = _pendingKey(pending.surveyId);
    final list = prefs.getStringList(key) ?? <String>[];
    list.add(jsonEncode(pending.toJson()));
    await prefs.setStringList(key, list);
  }

  @override
  Future<List<SurveySubmissionModel>> loadPending(String surveyId) async {
    final key = _pendingKey(surveyId);
    final list = prefs.getStringList(key) ?? <String>[];
    return list
        .map(
          (s) => SurveySubmissionModel.fromJson(
            jsonDecode(s) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<void> updatePending(SurveySubmissionModel updated) async {
    final key = _pendingKey(updated.surveyId);
    final list = prefs.getStringList(key) ?? <String>[];

    // identificador: createdAt + surveyId (suficiente para MVP)
    final targetId =
        '${updated.surveyId}_${updated.createdAt.toIso8601String()}';

    final next = <String>[];
    for (final raw in list) {
      final item = SurveySubmissionModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      final id = '${item.surveyId}_${item.createdAt.toIso8601String()}';
      next.add(id == targetId ? jsonEncode(updated.toJson()) : raw);
    }

    await prefs.setStringList(key, next);
  }

  @override
  Future<void> removePending(SurveySubmissionModel item) async {
    final key = _pendingKey(item.surveyId);
    final list = prefs.getStringList(key) ?? <String>[];

    final targetId = '${item.surveyId}_${item.createdAt.toIso8601String()}';

    final next = <String>[];
    for (final raw in list) {
      final current = SurveySubmissionModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      final id = '${current.surveyId}_${current.createdAt.toIso8601String()}';
      if (id != targetId) next.add(raw);
    }
    await prefs.setStringList(key, next);
  }

  @override
  Future<void> addToSentHistory(
    SurveySubmissionModel sent, {
    required String remoteCode,
    required String remoteMessage,
  }) async {
    final key = _historyKey(sent.surveyId);
    final list = prefs.getStringList(key) ?? <String>[];

    final entry = {
      ...sent.toJson(),
      'remoteCode': remoteCode,
      'remoteMessage': remoteMessage,
      'sentAt': DateTime.now().toIso8601String(),
    };

    list.add(jsonEncode(entry));
    await prefs.setStringList(key, list);
  }

  @override
  Future<List<Map<String, dynamic>>> loadSentHistory(String surveyId) async {
    final key = _historyKey(surveyId);
    final list = prefs.getStringList(key) ?? <String>[];
    return list.map((s) => jsonDecode(s) as Map<String, dynamic>).toList();
  }

  @override
  Future<void> clearPendingAll(String surveyId) async {
    await prefs.remove(_pendingKey(surveyId));
  }

  @override
  Future<void> removePendingById(String surveyId, String createdAtIso) async {
    final key = _pendingKey(surveyId);
    final list = prefs.getStringList(key) ?? <String>[];

    final targetId = '${surveyId}_$createdAtIso';

    final next = <String>[];
    for (final raw in list) {
      final current = SurveySubmissionModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      final id = '${current.surveyId}_${current.createdAt.toIso8601String()}';
      if (id != targetId) next.add(raw);
    }

    await prefs.setStringList(key, next);
  }

  @override
  Future<void> saveHistoryItem(SurveyHistoryModel item) async {
    final list = prefs.getStringList(_surveySentHistoryKey) ?? [];
    list.insert(0, jsonEncode(item.toJson())); // Add to top
    await prefs.setStringList(_surveySentHistoryKey, list);
  }

  @override
  Future<List<SurveyHistoryModel>> getHistory() async {
    final list = prefs.getStringList(_surveySentHistoryKey) ?? [];
    return list.map((e) => SurveyHistoryModel.fromJson(jsonDecode(e))).toList();
  }
}
