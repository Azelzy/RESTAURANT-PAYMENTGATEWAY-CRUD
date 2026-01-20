import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../widget/NavDrawer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  ContactController get contactController => Get.find<ContactController>();

  void _showEditDialog(BuildContext context, int index, String currentName) {
    final editController = TextEditingController(text: currentName);
    
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Text(
                  "EDIT CONTACT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: TextField(
                  controller: editController,
                  decoration: const InputDecoration(
                    labelText: "NEW NAME",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 1.0,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          editController.dispose();
                          Get.back();
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          final newName = editController.text.trim();
                          if (newName.isNotEmpty) {
                            contactController.updateName(index, newName);
                            editController.dispose();
                            Get.back();
                          }
                        },
                        child: const Text(
                          "UPDATE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int index, String name) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Text(
                  "DELETE CONTACT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      "ARE YOU SURE?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "THIS ACTION CANNOT BE UNDONE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          contactController.deleteName(index);
                          Get.back();
                        },
                        child: const Text(
                          "DELETE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "CONTACTS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: Colors.black, height: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            
            // Input Section
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: TextField(
                      controller: contactController.nameController,
                      decoration: const InputDecoration(
                        labelText: "INPUT NAME (TEXTFIELD)",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 1.0,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: IconButton(
                    onPressed: contactController.addName,
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // ListView Section
            Expanded(
              child: Obx(
                () => contactController.names.isEmpty
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(color: Colors.black, width: 2),
                                ),
                                child: Icon(
                                  Icons.contacts,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "NO CONTACTS YET",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey[600],
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "ADD YOUR FIRST CONTACT ABOVE",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[500],
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: contactController.names.length,
                        itemBuilder: (context, index) {
                          final name = contactController.names[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(color: Colors.black, width: 2),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[700],
                                  size: 24,
                                ),
                              ),
                              title: Text(
                                name.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "CONTACT #${contactController.names.length - index}",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        _showEditDialog(context, index, name);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        _showDeleteDialog(context, index, name);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}