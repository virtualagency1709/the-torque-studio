<?php
/**
 * RESTful Route Dispatcher
 */

namespace Torque;

use Torque\Utils\Response;

class Router {
    private array $routes = [];

    public function get(string $path, $handler, array $middlewares = []): void {
        $this->addRoute('GET', $path, $handler, $middlewares);
    }

    public function post(string $path, $handler, array $middlewares = []): void {
        $this->addRoute('POST', $path, $handler, $middlewares);
    }

    public function put(string $path, $handler, array $middlewares = []): void {
        $this->addRoute('PUT', $path, $handler, $middlewares);
    }

    public function patch(string $path, $handler, array $middlewares = []): void {
        $this->addRoute('PATCH', $path, $handler, $middlewares);
    }

    public function delete(string $path, $handler, array $middlewares = []): void {
        $this->addRoute('DELETE', $path, $handler, $middlewares);
    }

    private function addRoute(string $method, string $path, $handler, array $middlewares): void {
        $this->routes[] = [
            'method' => $method,
            'path' => $path,
            'pattern' => $this->convertPathToRegex($path),
            'handler' => $handler,
            'middlewares' => $middlewares
        ];
    }

    private function convertPathToRegex(string $path): string {
        $pattern = preg_replace('/\{([a-zA-Z0-9_]+)\}/', '(?P<$1>[^/]+)', $path);
        return '#^' . $pattern . '$#';
    }

    public function dispatch(string $method, string $uri): void {
        // Strip query string and base prefixes
        $path = parse_url($uri, PHP_URL_PATH);
        
        // Remove trailing slashes (except root)
        if ($path !== '/' && substr($path, -1) === '/') {
            $path = rtrim($path, '/');
        }

        $matchedMethod = false;

        foreach ($this->routes as $route) {
            if (preg_match($route['pattern'], $path, $matches)) {
                if ($route['method'] === $method) {
                    // Filter named matches
                    $params = array_filter($matches, 'is_string', ARRAY_FILTER_USE_KEY);

                    // Execute middlewares
                    foreach ($route['middlewares'] as $mw) {
                        call_user_func($mw);
                    }

                    // Execute handler
                    if (is_array($route['handler'])) {
                        list($class, $action) = $route['handler'];
                        $instance = new $class();
                        call_user_func_array([$instance, $action], array_values($params));
                    } elseif (is_callable($route['handler'])) {
                        call_user_func_array($route['handler'], array_values($params));
                    }
                    return;
                }
                $matchedMethod = true;
            }
        }

        if ($matchedMethod) {
            Response::error('Method not allowed', 405);
        } else {
            Response::error("Endpoint '$path' not found", 404);
        }
    }
}
