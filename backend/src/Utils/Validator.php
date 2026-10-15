<?php
/**
 * Server-Side Input Validator & Sanitizer
 */

namespace Torque\Utils;

class Validator {
    private array $data;
    private array $errors = [];

    public function __construct(array $data) {
        $this->data = $data;
    }

    public static function make(array $data): self {
        return new self($data);
    }

    public function required(string $field, string $customName = ''): self {
        $name = $customName ?: $field;
        if (!isset($this->data[$field]) || trim((string)$this->data[$field]) === '') {
            $this->errors[$field][] = "$name is required.";
        }
        return $this;
    }

    public function email(string $field, string $customName = ''): self {
        $name = $customName ?: $field;
        if (!empty($this->data[$field])) {
            $val = trim((string)$this->data[$field]);
            if (!filter_var($val, FILTER_VALIDATE_EMAIL)) {
                $this->errors[$field][] = "$name must be a valid email address.";
            }
        }
        return $this;
    }

    public function phone(string $field, string $customName = ''): self {
        $name = $customName ?: $field;
        if (!empty($this->data[$field])) {
            $val = preg_replace('/[\s\-\(\)\+]/', '', (string)$this->data[$field]);
            if (strlen($val) < 8 || strlen($val) > 15 || !ctype_digit($val)) {
                $this->errors[$field][] = "$name must be a valid contact number.";
            }
        }
        return $this;
    }

    public function minLength(string $field, int $min, string $customName = ''): self {
        $name = $customName ?: $field;
        if (!empty($this->data[$field]) && mb_strlen(trim((string)$this->data[$field])) < $min) {
            $this->errors[$field][] = "$name must be at least $min characters long.";
        }
        return $this;
    }

    public function maxLength(string $field, int $max, string $customName = ''): self {
        $name = $customName ?: $field;
        if (!empty($this->data[$field]) && mb_strlen(trim((string)$this->data[$field])) > $max) {
            $this->errors[$field][] = "$name cannot exceed $max characters.";
        }
        return $this;
    }

    public function date(string $field, string $customName = ''): self {
        $name = $customName ?: $field;
        if (!empty($this->data[$field])) {
            $d = \DateTime::createFromFormat('Y-m-d', $this->data[$field]);
            if (!$d || $d->format('Y-m-d') !== $this->data[$field]) {
                $this->errors[$field][] = "$name must be a valid date in YYYY-MM-DD format.";
            }
        }
        return $this;
    }

    public function passes(): bool {
        return empty($this->errors);
    }

    public function fails(): bool {
        return !empty($this->errors);
    }

    public function getErrors(): array {
        return $this->errors;
    }

    public static function sanitize(string $input): string {
        return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
    }
}
