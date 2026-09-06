import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/auth_text_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateState);
    _emailController.addListener(_updateState);
    _passwordController.addListener(_updateState);
    _confirmPasswordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isNameFilled => _nameController.text.trim().isNotEmpty;
  bool get _isEmailFilled => _emailController.text.trim().isNotEmpty && _emailController.text.contains('@');
  bool get _isPasswordFilled => _passwordController.text.trim().length >= 8;
  bool get _isConfirmFilled => _confirmPasswordController.text.trim().isNotEmpty && _confirmPasswordController.text == _passwordController.text;

  int get _filledCount {
    int count = 0;
    if (_isNameFilled) count++;
    if (_isEmailFilled) count++;
    if (_isPasswordFilled) count++;
    if (_isConfirmFilled) count++;
    return count;
  }

  void _nextStep() {
    if (!_isNameFilled || !_isEmailFilled) {
      _formKey.currentState?.validate();
      return;
    }

    _formKey.currentState?.reset();

    setState(() {
      _currentStep = 2;
    });
  }

  void _prevStep() {
    _formKey.currentState?.reset();

    setState(() {
      _currentStep = 1;
    });
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ref.read(authViewModelProvider.notifier).signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final isLoading = authState.isLoading;

    ref.listen<AsyncValue<dynamic>>(authViewModelProvider, (_, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    final percentageInt = (_filledCount / 4 * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () {
            if (_currentStep == 2) {
              _prevStep();
            } else {
              context.pushReplacement('/gatekeeper');
            }
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Comienza tu viaje',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Crea una cuenta para registrar y descubrir nuevos horizontes.',
                  style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Paso $_currentStep de 2: ${_currentStep == 1 ? 'Información personal' : 'Seguridad'}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      '$percentageInt%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic, // Texto de progreso en cursiva
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(child: _buildSegment(_isNameFilled)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildSegment(_isEmailFilled)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildSegment(_isPasswordFilled)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildSegment(_isConfirmFilled)),
                  ],
                ),
                const SizedBox(height: 32),

                if (_currentStep == 1) ...[
                  AuthTextField(
                    controller: _nameController,
                    labelText: '¿Cómo te llamas?',
                    hintText: 'Ej. Juan Pérez',
                    prefixIcon: Icons.person_outline,
                    validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _emailController,
                    labelText: 'Correo electrónico',
                    hintText: 'correo@ejemplo.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      if (!value.contains('@')) return 'Ingresa un correo válido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: _nextStep,
                      child: const Text('Siguiente', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ] else ...[
                  AuthTextField(
                    controller: _passwordController,
                    labelText: 'Contraseña',
                    hintText: 'Mínimo 8 caracteres',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      if (value.length < 8) return 'Debe tener al menos 8 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirmar contraseña',
                    hintText: 'Repite tu contraseña',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      if (value != _passwordController.text) return 'Las contraseñas no coinciden';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF1E293B)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: _prevStep,
                            child: const Text('Atrás', style: TextStyle(fontSize: 16, color: Color(0xFF1E293B))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 56,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF1E293B),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: isLoading ? null : _submit,
                            child: isLoading
                                ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white))
                                : const Text('Crear cuenta', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Ya tienes cuenta?', style: TextStyle(color: Color(0xFF64748B))),
                    TextButton(
                      onPressed: () => context.pushReplacement('/login'),
                      child: const Text(
                        'Inicia sesión',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSegment(bool isCompleted) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFE2E8F0), // Verde esmeralda si está listo, gris si falta
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}