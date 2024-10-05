extends Node


#region Controllers
signal controller_connected(device: int, controller_name: String)
signal controller_disconnected(device: int, controller_name: String)
#endregion

#region Scenes
signal scene_transition_requested(next_scene_path)
signal scene_transition_finished(next_scene_path)
#endregion

#region Settings
signal mouse_sensitivity_changed(sensitivity: float)
signal changed_language(language: String)
signal changed_subtitles_language(language: String)
signal changed_voices_language(language: String)
signal changed_subtitles_enabled(enabled: bool)
signal updated_graphic_settings(quality_preset: int) # QualityPreset enum from HardwareDetector
#endregion



#region Narrative
#signal dialogues_requested(dialogue_blocks: Array[DialogueDisplayer.DialogueBlock])
#signal dialogue_display_started(dialogue: DialogueDisplayer.DialogueBlock)
#signal dialogue_display_finished(dialogue: DialogueDisplayer.DialogueBlock)
#signal dialogue_blocks_started_to_display(dialogue_blocks: Array[DialogueDisplayer.DialogueBlock])
#signal dialogue_blocks_finished_to_display()
#endregion
