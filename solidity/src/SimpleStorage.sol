contract SimpleStorage {
    uint256 private _value;

    function setValue(uint256 value) external {
        _value = value;
    }

    function getValue() external view returns (uint256) {
        return _value;
    }

    function div(uint256 divisor) external view returns (uint256) {
        return _value / divisor;
    }
}