import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';

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
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Task Name",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                hintText: "Enter task name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTimeField("Start Time", startTimeCtrl, context),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTimeField("End Time", endTimeCtrl, context),
                ),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField(
    String label,
    TextEditingController ctrl,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "e.g. 16:00",
            suffixIcon: const Icon(Icons.access_time),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              ctrl.text = time.format(context);
            }
          },
        ),
      ],
    );
  }
}
