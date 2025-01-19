export class AppUtils {
  static getCssVariable(variableName: string): string {
    // Fetch the root element's styles
    return getComputedStyle(document.documentElement)
      .getPropertyValue(variableName)
      .trim();
  }
  static getErrorMessage(error: any): string {
    return error?.error?.message || 'An error occurred';
  }
  static convertToEnum<T extends Record<string, string>>(
    enumObj: T,
    value: string
  ): T[keyof T] {
    const enumValues = Object.values(enumObj);
    const matchedValue = enumValues.find(
      (enumValue) => enumValue.toLowerCase() === value.toLowerCase()
    );
    return matchedValue as T[keyof T];
  }
}
