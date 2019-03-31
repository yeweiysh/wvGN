% Creates a matrix W from A where the each row is normalized by its sum. If
% A is sparse W is sparse.

function W=normrow(A)

W=degree_inv(A)*A;

end