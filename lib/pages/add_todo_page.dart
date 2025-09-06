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
            // Task name
            const Text("Task Name", style: TextStyle(fontWeight: FontWeight.w600)),
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

            // Start & End Time
            Row(
              children: [
                Expanded(child: _buildTimeField("Start Time", startTimeCtrl, context)),
                const SizedBox(width: 12),
                Expanded(child: _buildTimeField("End Time", endTimeCtrl, context)),
              ],
            ),

            const SizedBox(height: 20),

            // Color picker
            const Text("Color", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Obx(() => Row(
                  children: List.generate(4, (index) {
                    final colors = [Colors.purple, Colors.blue, Colors.teal, Colors.orange];
                    return GestureDetector(
                      onTap: () => selectedColor.value = index,
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor.value == index ? Colors.black : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }),
                )),

            const Spacer(),

            // Add button
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
                  // ✅ hanya panggil controller, logic ada di controller
                  controller.addTodo(
                    titleCtrl.text,
                    "${startTimeCtrl.text} - ${endTimeCtrl.text}",
                    selectedColor.value,
                  );
                  Get.back();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// widget helper untuk time picker
  Widget _buildTimeField(String label, TextEditingController ctrl, BuildContext context) {
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
