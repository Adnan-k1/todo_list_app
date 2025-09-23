import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';

class AddTodoPage extends GetView<TodoController> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController startTimeCtrl = TextEditingController();
  final TextEditingController endTimeCtrl = TextEditingController();

  final RxInt selectedColor = 0.obs;

  AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: const Color(0xFFEFF6F9),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: titleCtrl,
              label: "Task Name",
              hint: "Enter task name",
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: startTimeCtrl,
                    label: "Start Time",
                    hint: "e.g. 16:00",
                    readOnly: true,
                    suffixIcon: const Icon(Icons.access_time),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        startTimeCtrl.text = time.format(context);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: endTimeCtrl,
                    label: "End Time",
                    hint: "e.g. 17:00",
                    readOnly: true,
                    suffixIcon: const Icon(Icons.access_time),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        endTimeCtrl.text = time.format(context);
                      }
                    },
                  ),
                ),
              ],
            ),

            const Spacer(),

            CustomButton(
              text: "Add",
              onPressed: () {
                if (titleCtrl.text.isEmpty) {
                  Get.snackbar("Error", "Task name tidak boleh kosong",
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                Get.defaultDialog(
                  title: "Konfirmasi",
                  middleText: "Apakah kamu yakin ingin menyimpan task ini?",
                  textCancel: "Batal",
                  textConfirm: "Simpan",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.addTodo(
                      titleCtrl.text,
                      "${startTimeCtrl.text} - ${endTimeCtrl.text}",
                      selectedColor.value,
                    );

                    Get.back();
                    Get.back();
                    Get.snackbar("Sukses", "Todo berhasil ditambahkan",
                        snackPosition: SnackPosition.TOP);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
