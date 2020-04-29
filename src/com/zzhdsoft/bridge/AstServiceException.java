package com.zzhdsoft.bridge;

/**
 * Service Exception
 */
public class AstServiceException extends RuntimeException {
    public AstServiceException() {
    }

    public AstServiceException(String message) {
        super(message);
    }

    public AstServiceException(String message, Throwable cause) {
        super(message, cause);
    }

    public AstServiceException(Throwable cause) {
        super(cause);
    }
}
